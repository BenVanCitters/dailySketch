using UnityEngine;
using System.Collections;

public class physicsDumper : MonoBehaviour {

	public float creationDelay = 0.3f;
	public int maxBoxCount = 20;
	float tickDown = 0;
	ArrayList boxes = new ArrayList();
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		this.tickDown -= Time.deltaTime;
		if (this.tickDown <= 0)
		{
			DumpThing();
			this.tickDown = creationDelay;
		}
		CullBoxes();
	}

	void DumpThing()
	{
		GameObject cube = GameObject.CreatePrimitive(PrimitiveType.Cube);
		cube.AddComponent<Rigidbody>();
		Vector3 offset = Random.insideUnitSphere;
		cube.transform.SetParent(this.transform);
		cube.transform.position = this.transform.position+offset;

		Material newMat = Resources.Load("New Material", typeof(Material)) as Material;
		var renderer = cube.GetComponent<MeshRenderer>();
		renderer.material = newMat;

		boxes.Add(cube);
	}

	void CullBoxes()
	{
		while(boxes.Count > maxBoxCount)
		{
			GameObject g = (GameObject)boxes[0];
			boxes.RemoveAt(0);
			GameObject.Destroy(g);
		}
	}
}
