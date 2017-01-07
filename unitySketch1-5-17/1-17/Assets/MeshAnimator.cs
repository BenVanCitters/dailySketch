using UnityEngine;
using System.Collections;

public class MeshAnimator : MonoBehaviour {
	Mesh myMesh;
	Vector3[] originalVerticies;
	Vector3[] newVerts;

	Vector3 startPos;

	float startTimeOffset = Random.value * Mathf.PI*2;
	// Use this for initialization
	void Start () {
		MeshFilter c = GetComponent<MeshFilter>();

		myMesh = c.mesh;
		myMesh.MarkDynamic();
		print("submeshCount: " + myMesh.subMeshCount);

		int[] tris = myMesh.GetTriangles(0);

		Vector3[] v3 = myMesh.vertices;
		originalVerticies = new Vector3[myMesh.vertices.Length];
		newVerts = new Vector3[myMesh.vertices.Length];
		for(int i = 0; i < v3.Length; i++)
		{
			originalVerticies[i] = v3[i];
		}

		startPos = this.transform.position;
	}

	
	// Update is called once per frame
	void Update () {



		float tm = Time.realtimeSinceStartup;

		this.transform.position = startPos + new Vector3(0,
			2 * Mathf.Sin(tm+startTimeOffset),
			0);
		
		for(int i = 0; i < newVerts.Length; i++)
		{
//			newVerts[i] = originalVerticies[i] + Random.onUnitSphere * 0.1f;
			Vector3 offset = new Vector3( Mathf.Sin(tm*5 + (originalVerticies[i].y+transform.position.y)*10), 
				0.0f,
				Mathf.Sin(tm*5 + (originalVerticies[i].y+transform.position.y)*10))*0.2f;
			newVerts[i] = originalVerticies[i] + offset;
		}
		myMesh.vertices = newVerts;
		myMesh.RecalculateNormals();
	}
}
