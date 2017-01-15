using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SinMover : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {

		float tm = Time.realtimeSinceStartup*0.3f;

		Vector3 result =new Vector3(
			Mathf.Sin(2.2f*tm)+ Mathf.Sin(tm), 
			Mathf.Cos(1.5f*tm), 
			Mathf.Cos(-tm*3.0f) );
		result *= 9;
		transform.localPosition = result;
			
	}
}
