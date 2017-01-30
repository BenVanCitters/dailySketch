using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SphericalModler : MonoBehaviour 
{

	public int phiDivs = 10;
	public int thetaDivs = 10;

	public int xMod1Period = 4;
	public float xMod1PhaseOffset = 1.0f;
	public float xMod1Scale = 2.0f;
	public float xMod1YOffset = 1.1f;
	public float xMod1TimeResponse = 1.0f;

	public int yMod1Period = 4;
	public float yMod1PhaseOffset = 1.0f;
	public float yMod1Scale = 2.0f;
	public float yMod1YOffset = 1.1f;
	public float yMod1TimeResponse = 1.0f;

	// Use this for initialization
	void Start () 
	{
		GetComponent<MeshFilter>().mesh = new Mesh();
	}
	
	// Update is called once per frame
	void Update () 
	{
		
		this.UpdateMesh( GetComponent<MeshFilter>().mesh );
	}

	Mesh UpdateMesh(Mesh m)
	{
		if(m == null)
		{
			m = new Mesh();
		}

		m.Clear();

		Vector3[] vectors = new Vector3[phiDivs * thetaDivs];
		Vector2[] uvs = new Vector2[phiDivs * thetaDivs];
		float radsPerPhiDiv = Mathf.PI/(phiDivs-1);
		float radsPerThetaDiv = 2.0f*Mathf.PI/thetaDivs;

		float seconds = Time.timeSinceLevelLoad;

		int vIndex = 0;
		for(int i=0; i < phiDivs; i++)
		{
			float phi = radsPerPhiDiv*i;

			for(int j=0; j < thetaDivs; j++)
			{
				float theta = radsPerThetaDiv*j;	
				float radius = GetRadius(phi,theta,seconds);
				uvs[vIndex] = new Vector2(j*1.0f/thetaDivs,i*1.0f/phiDivs);
				vectors[vIndex++] = new Vector3(radius*Mathf.Sin(phi)*Mathf.Cos(theta),
												radius*Mathf.Sin(phi)*Mathf.Sin(theta),
												radius*Mathf.Cos(phi));
				
			}
		}
		m.vertices = vectors;
		m.uv = uvs;
		//assign triangles
		int triCount = 2 * (phiDivs-1) * (thetaDivs);
		int[] triIndecies = new int[triCount*3];
		int curTriIndex = 0;
		for(int i=0; i < phiDivs-1; i++)
		{
			for(int j=0; j < thetaDivs; j++)
			{
				int ul = i*thetaDivs+j;
				int ur = i*thetaDivs+ ((j+1) % thetaDivs);
				int ll = (i+1)*thetaDivs+j;
				int lr = (i+1)*thetaDivs+ ((j+1) % thetaDivs);
				triIndecies[curTriIndex++] = ul;
				triIndecies[curTriIndex++] = ll;
				triIndecies[curTriIndex++] = ur;

				triIndecies[curTriIndex++] = ll;
				triIndecies[curTriIndex++] = lr;
				triIndecies[curTriIndex++] = ur;
			}
		}
		m.triangles = triIndecies;
		m.RecalculateNormals();
		return m;
	}

	float GetRadius(float phi, float theta, float time = 0)
	{
		
		return xMod1YOffset + xMod1Scale*Mathf.Sin(xMod1TimeResponse*time + theta*xMod1Period + xMod1PhaseOffset) +
			yMod1YOffset + yMod1Scale*Mathf.Sin(yMod1TimeResponse*time + phi*yMod1Period + yMod1PhaseOffset);
	}

	private void OnDrawGizmos () {

		Gizmos.color = Color.cyan;
		Gizmos.DrawWireMesh(UpdateMesh(null));

	}
}
