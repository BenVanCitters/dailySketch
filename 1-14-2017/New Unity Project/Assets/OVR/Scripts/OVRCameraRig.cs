/************************************************************************************

Copyright   :   Copyright 2014 Oculus VR, LLC. All Rights reserved.

Licensed under the Oculus VR Rift SDK License Version 3.3 (the "License");
you may not use the Oculus VR Rift SDK except in compliance with the License,
which is provided at the time of installation or download, or which
otherwise accompanies this software in either electronic or hard copy form.

You may obtain a copy of the License at

http://www.oculus.com/licenses/LICENSE-3.3

Unless required by applicable law or agreed to in writing, the Oculus VR SDK
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

************************************************************************************/

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// A head-tracked stereoscopic virtual reality camera rig.
/// </summary>
[ExecuteInEditMode]
public class OVRCameraRig : MonoBehaviour
{
	/// <summary>
	/// The left eye camera.
	/// </summary>
	public Camera leftEyeCamera { get; private set; }
	/// <summary>
	/// The right eye camera.
	/// </summary>
	public Camera rightEyeCamera { get; private set; }
	/// <summary>
	/// Provides a root transform for all anchors in tracking space.
	/// </summary>
	public Transform trackingSpace { get; private set; }
	/// <summary>
	/// Always coincides with the pose of the left eye.
	/// </summary>
	public Transform leftEyeAnchor { get; private set; }
	/// <summary>
	/// Always coincides with average of the left and right eye poses.
	/// </summary>
	public Transform centerEyeAnchor { get; private set; }
	/// <summary>
	/// Always coincides with the pose of the right eye.
	/// </summary>
	public Transform rightEyeAnchor { get; private set; }
	/// <summary>
	/// Always coincides with the pose of the left hand.
	/// </summary>
	public Transform leftHandAnchor { get; private set; }
	/// <summary>
	/// Always coincides with the pose of the right hand.
	/// </summary>
	public Transform rightHandAnchor { get; private set; }
	/// <summary>
	/// Always coincides with the pose of the sensor.
	/// </summary>
	public Transform trackerAnchor { get; private set; }
	/// <summary>
	/// Occurs when the eye pose anchors have been set.
	/// </summary>
	public event System.Action<OVRCameraRig> UpdatedAnchors;

	private bool needsCameraConfigure = true;
	private readonly string trackingSpaceName = "TrackingSpace";
	private readonly string trackerAnchorName = "TrackerAnchor";
	private readonly string eyeAnchorName = "EyeAnchor";
	private readonly string handAnchorName = "HandAnchor";
	private readonly string legacyEyeAnchorName = "Camera";
	private Material mat;

#if !UNITY_ANDROID || UNITY_EDITOR
	private Camera mirrorCamera;
#endif

#region Unity Messages
	private void Awake()
	{
		EnsureGameObjectIntegrity();
		
		if (!Application.isPlaying)
			return;
		
		OVRManager.Created += () => { needsCameraConfigure = true; };
		OVRManager.NativeTextureScaleModified += (prev, current) => { needsCameraConfigure = true; };
		OVRManager.VirtualTextureScaleModified += (prev, current) => { needsCameraConfigure = true; };
		OVRManager.EyeTextureAntiAliasingModified += (prev, current) => { needsCameraConfigure = true; };
		OVRManager.EyeTextureDepthModified += (prev, current) => { needsCameraConfigure = true; };
		OVRManager.EyeTextureFormatModified += (prev, current) => { needsCameraConfigure = true; };
		OVRManager.MonoscopicModified += (prev, current) => { needsCameraConfigure = true; };
		OVRManager.HdrModified += (prev, current) => { needsCameraConfigure = true; };
	}

	private void Start()
	{
		if (Application.isPlaying)
			OVRManager.display.UpdatedTracking += ApplyTracking;

		ApplyTracking();
	}

	private void OnDestroy()
	{
		if (Application.isPlaying)
			OVRManager.display.UpdatedTracking -= ApplyTracking;
	}

	void ApplyTracking()
	{
		EnsureGameObjectIntegrity();
		
		if (!Application.isPlaying)
			return;

		UpdateCameras();
		UpdateAnchors();
	}

#if !UNITY_ANDROID || UNITY_EDITOR
	void OnRenderImage(RenderTexture src, RenderTexture dst)
	{
		if (!OVRManager.display.mirrorMode || !OVRManager.instance.isVRPresent || leftEyeCamera == null || leftEyeCamera.targetTexture == null)
		{
			Graphics.Blit(src, dst);
			return;
		}

		Vector2 scale = Vector2.one;
		Vector2 offset = Vector2.zero;
		
		// Correct the texture's aspect ratio to match the viewport.
		float texAspect = (float)leftEyeCamera.targetTexture.width / (float)leftEyeCamera.targetTexture.height;
		float screenAspect = (float)Screen.width / (float)Screen.height;
		float aspect = screenAspect / texAspect;
		
		if (aspect < 1f)
		{
			scale.x = aspect;
			offset.x = -0.5f * (aspect - 1f);
		}
		else
		{
			scale.y = 1f/aspect;
			offset.y = -0.5f * (1f/aspect - 1f);
		}

		float virtualScale = OVRPlugin.virtualTextureScale;

		// Apply render scaling.
		scale *= virtualScale;
		offset *= virtualScale;
		
		// Flip vertically.
		offset.y = 1f - virtualScale + offset.y;

		if (!mat)
			mat = new Material(Shader.Find("Oculus/BlitCopy"));

		mat.SetTextureScale("_MainTex", scale);
		mat.SetTextureOffset("_MainTex", offset);

		Graphics.Blit(leftEyeCamera.targetTexture, dst, mat);
	}
#endif

#endregion

	private void UpdateAnchors()
	{
		if (!OVRManager.instance.isVRPresent)
			return;

		bool monoscopic = OVRManager.instance.monoscopic;

		OVRPose tracker = OVRManager.tracker.GetPose(0f);
		OVRPose leftHand = OVRPlugin.GetNodePose(OVRPlugin.Node.HandLeft).ToOVRPose();
		OVRPose rightHand = OVRPlugin.GetNodePose(OVRPlugin.Node.HandRight).ToOVRPose();
		OVRPose hmdLeftEye = OVRManager.display.GetEyePose(OVREye.Left);
		OVRPose hmdRightEye = OVRManager.display.GetEyePose(OVREye.Right);

		trackerAnchor.localRotation = tracker.orientation;
		leftHandAnchor.localRotation = leftHand.orientation;
		rightHandAnchor.localRotation = rightHand.orientation;
		centerEyeAnchor.localRotation = hmdLeftEye.orientation; // using left eye for now
		leftEyeAnchor.localRotation = monoscopic ? centerEyeAnchor.localRotation : hmdLeftEye.orientation;
		rightEyeAnchor.localRotation = monoscopic ? centerEyeAnchor.localRotation : hmdRightEye.orientation;

		trackerAnchor.localPosition = tracker.position;
		leftHandAnchor.localPosition = leftHand.position;
		rightHandAnchor.localPosition = rightHand.position;
		centerEyeAnchor.localPosition = 0.5f * (hmdLeftEye.position + hmdRightEye.position);
		leftEyeAnchor.localPosition = monoscopic ? centerEyeAnchor.localPosition : hmdLeftEye.position;
		rightEyeAnchor.localPosition = monoscopic ? centerEyeAnchor.localPosition : hmdRightEye.position;

		if (UpdatedAnchors != null)
		{
			UpdatedAnchors(this);
		}
	}

	private void UpdateCameras()
	{
		if (!OVRManager.instance.isVRPresent)
			return;

		if (needsCameraConfigure)
		{
			leftEyeCamera = ConfigureCamera(OVREye.Left);
			rightEyeCamera = ConfigureCamera(OVREye.Right);

#if !UNITY_ANDROID || UNITY_EDITOR
			if (Application.isPlaying)
			{
				mirrorCamera.cullingMask = 0;
				mirrorCamera.renderingPath = RenderingPath.Forward;
				mirrorCamera.targetTexture = null;
				mirrorCamera.tag = "";
			}

			needsCameraConfigure = false;
#endif
		}
	}

	public void EnsureGameObjectIntegrity()
	{
		if (trackingSpace == null)
			trackingSpace = ConfigureRootAnchor(trackingSpaceName);

		if (leftEyeAnchor == null)
			leftEyeAnchor = ConfigureEyeAnchor(trackingSpace, OVREye.Left);

		if (centerEyeAnchor == null)
			centerEyeAnchor = ConfigureEyeAnchor(trackingSpace, OVREye.Center);

		if (rightEyeAnchor == null)
			rightEyeAnchor = ConfigureEyeAnchor(trackingSpace, OVREye.Right);

		if (leftHandAnchor == null)
            leftHandAnchor = ConfigureHandAnchor(trackingSpace, OVRPlugin.Node.HandLeft);

		if (rightHandAnchor == null)
            rightHandAnchor = ConfigureHandAnchor(trackingSpace, OVRPlugin.Node.HandRight);

		if (trackerAnchor == null)
			trackerAnchor = ConfigureTrackerAnchor(trackingSpace);

		if (leftEyeCamera == null)
		{
			leftEyeCamera = leftEyeAnchor.GetComponent<Camera>();
			if (leftEyeCamera == null)
			{
				leftEyeCamera = leftEyeAnchor.gameObject.AddComponent<Camera>();
			}
#if UNITY_ANDROID && !UNITY_EDITOR
			if (leftEyeCamera.GetComponent<OVRPostRender>() == null)
			{
				leftEyeCamera.gameObject.AddComponent<OVRPostRender>();
			}
#endif
		}

		if (rightEyeCamera == null)
		{
			rightEyeCamera = rightEyeAnchor.GetComponent<Camera>();
			if (rightEyeCamera == null)
			{
				rightEyeCamera = rightEyeAnchor.gameObject.AddComponent<Camera>();
			}
#if UNITY_ANDROID && !UNITY_EDITOR
			if (rightEyeCamera.GetComponent<OVRPostRender>() == null)
			{
				rightEyeCamera.gameObject.AddComponent<OVRPostRender>();
			}
#endif
		}

#if !UNITY_ANDROID || UNITY_EDITOR
		if (Application.isPlaying && mirrorCamera == null)
		{
			mirrorCamera = GetComponent<Camera>();
			if (mirrorCamera == null)
				mirrorCamera = gameObject.AddComponent<Camera>();
		}
#endif
	}

	private Transform ConfigureRootAnchor(string name)
	{
		Transform root = transform.Find(name);

		if (root == null)
		{
			root = new GameObject(name).transform;
		}

		root.parent = transform;
		root.localScale = Vector3.one;
		root.localPosition = Vector3.zero;
		root.localRotation = Quaternion.identity;

		return root;
	}

	private Transform ConfigureEyeAnchor(Transform root, OVREye eye)
	{
		string name = eye.ToString() + eyeAnchorName;
		Transform anchor = transform.Find(root.name + "/" + name);

		if (anchor == null)
		{
			anchor = transform.Find(name);
		}

		if (anchor == null)
		{
			string legacyName = legacyEyeAnchorName + eye.ToString();
			anchor = transform.Find(legacyName);
		}

		if (anchor == null)
		{
			anchor = new GameObject(name).transform;
		}

		anchor.name = name;
		anchor.parent = root;
		anchor.localScale = Vector3.one;
		anchor.localPosition = Vector3.zero;
		anchor.localRotation = Quaternion.identity;

		return anchor;
	}

	private Transform ConfigureTrackerAnchor(Transform root)
	{
		string name = trackerAnchorName;
		Transform anchor = transform.Find(root.name + "/" + name);

		if (anchor == null)
		{
			anchor = new GameObject(name).transform;
		}

		anchor.parent = root;
		anchor.localScale = Vector3.one;
		anchor.localPosition = Vector3.zero;
		anchor.localRotation = Quaternion.identity;

		return anchor;
	}

	private Transform ConfigureHandAnchor(Transform root, OVRPlugin.Node hand)
	{
		if (hand != OVRPlugin.Node.HandLeft && hand != OVRPlugin.Node.HandRight)
			return null;

		string handName = (hand == OVRPlugin.Node.HandLeft) ? "Left" : "Right";
		string name = handName + handAnchorName;
		Transform anchor = transform.Find(root.name + "/" + name);

		if (anchor == null)
		{
			anchor = transform.Find(name);
		}

		if (anchor == null)
		{
			anchor = new GameObject(name).transform;
		}

		anchor.name = name;
		anchor.parent = root;
		anchor.localScale = Vector3.one;
		anchor.localPosition = Vector3.zero;
		anchor.localRotation = Quaternion.identity;

		return anchor;
	}

	private Camera ConfigureCamera(OVREye eye)
	{
		Transform anchor = (eye == OVREye.Left) ? leftEyeAnchor : rightEyeAnchor;
		Camera cam = anchor.GetComponent<Camera>();

		OVRDisplay.EyeRenderDesc eyeDesc = OVRManager.display.GetEyeRenderDesc(eye);

		cam.fieldOfView = eyeDesc.fov.y;
		cam.aspect = eyeDesc.resolution.x / eyeDesc.resolution.y;
		cam.targetTexture = OVRManager.display.GetEyeTexture(eye);
		cam.hdr = OVRManager.instance.hdr;

#if UNITY_ANDROID && !UNITY_EDITOR
		// Enforce camera render order
		cam.depth = (eye == OVREye.Left) ?
				(int)RenderEventType.LeftEyeEndFrame :
				(int)RenderEventType.RightEyeEndFrame;

		// If we don't clear the color buffer with a glClear, tiling GPUs
		// will be forced to do an "unresolve" and read back the color buffer information.
		// The clear is free on PowerVR, and possibly Mali, but it is a performance cost
		// on Adreno, and we would be better off if we had the ability to discard/invalidate
		// the color buffer instead of clearing.

		// NOTE: The color buffer is not being invalidated in skybox mode, forcing an additional,
		// wasted color buffer read before the skybox is drawn.
		bool hasSkybox = ((cam.clearFlags == CameraClearFlags.Skybox) &&
		                 ((cam.gameObject.GetComponent<Skybox>() != null) || (RenderSettings.skybox != null)));
		cam.clearFlags = (hasSkybox) ? CameraClearFlags.Skybox : CameraClearFlags.SolidColor;
#else
		float vs = OVRManager.instance.virtualTextureScale;
		cam.rect = new Rect(0f, 1f - vs, vs, vs);
#endif

		// When rendering monoscopic, we will use the left camera render for both eyes.
		if (eye == OVREye.Right)
		{
			cam.enabled = !OVRManager.instance.monoscopic;
		}

		// AA is documented to have no effect in deferred, but it causes black screens.
		if (cam.actualRenderingPath == RenderingPath.DeferredLighting)
			OVRManager.instance.eyeTextureAntiAliasing = OVRManager.RenderTextureAntiAliasing._1;

		return cam;
	}
}