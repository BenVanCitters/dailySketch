using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SPINNER : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		transform.Rotate(new Vector3(1.01f,1.2f,0.999f));
	}
}
