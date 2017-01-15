using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PivotAxis : object {
	public Vector3 axis;
	public Vector3 pivot;
	public PivotAxis(Vector3 p, Vector3 a){pivot = p; axis = a;}
}

public class CustomAnimator : MonoBehaviour {


	private float rotRemainder = 0;
	public GameObject target;
	public float sideLength = .5f;
	private PivotAxis[] pivots;
	private PivotAxis currentPivot;
	Vector3 pivot;// = new Vector3(0.5f,0.5f,0f);	//Vector3(0.5f,0.5f,0f);
	public float speed = 50;
	// Use this for initialization
	void Start () {
		float ofs = sideLength;
		pivots = new PivotAxis[]{
			new PivotAxis(new Vector3(0,ofs,ofs),Vector3.left), 		//0 front-top
			new PivotAxis(new Vector3(ofs,0,ofs),Vector3.down), 			//1 front-left
			new PivotAxis(new Vector3(-ofs,0,ofs),Vector3.down),			//2 front-right
			new PivotAxis(new Vector3(0,-ofs,ofs),Vector3.left),		//3 front-bottom
			new PivotAxis(new Vector3(0,ofs,-ofs),Vector3.left),		//4 back-top
			new PivotAxis(new Vector3(ofs,0,-ofs),Vector3.down),			//5 back-left
			new PivotAxis(new Vector3(-ofs,0,-ofs),Vector3.down),			//6 back-right
			new PivotAxis(new Vector3(0,-ofs,-ofs),Vector3.left),		//7 back-bottom
			new PivotAxis(new Vector3(-ofs,ofs,0),Vector3.back),		//8 top-right
			new PivotAxis(new Vector3(ofs,ofs,0),Vector3.back),		//9 top-left
			new PivotAxis(new Vector3(-ofs,-ofs,0),Vector3.back),	//10 bottom-right
			new PivotAxis(new Vector3(ofs,-ofs,0),Vector3.back),};	//11 bottom-left
		currentPivot = pivots[0];
	}
		
	// Update is called once per frame
	void Update () {
		

		float t = speed * Time.deltaTime;
		bool animComplete = false;
		if(rotRemainder - t <= 0)
		{
			t = rotRemainder;
			animComplete = true;
		}
		rotRemainder -= t;

		transform.RotateAround(pivot, currentPivot.axis, t);

		if(animComplete)
		{
			Vector3 diff = target.transform.position-transform.position;
			Vector3 diffAbs = new Vector3(Mathf.Abs(diff.x),Mathf.Abs(diff.y),Mathf.Abs(diff.z));
			float minMoveDist = sideLength*3;
			bool dirMoveRandomizer = Random.value > .5;
			if(diffAbs.x > minMoveDist || diffAbs.y > minMoveDist || diffAbs.z > minMoveDist)
			{
				AudioSource audio = GetComponent<AudioSource>();
				audio.pitch = 1 + Random.Range(-.1f,.1f);
				audio.Play();
				if(diffAbs.x >= diffAbs.y && diffAbs.x >= diffAbs.z)
				{
					if(diff.x > 0)
					{
						if(dirMoveRandomizer)
						{
						currentPivot = pivots[1]; //front left
						}else{
						currentPivot = pivots[11]; //bottom left
						}
					} else {

						if(dirMoveRandomizer)
						{
							currentPivot = pivots[6]; //back right
						}else{
							currentPivot = pivots[8]; //top right
						}
					}
				}
				else if(diffAbs.y >= diffAbs.x && diffAbs.y >= diffAbs.z)
				{
					if(diff.y > 0)
					{
						if(dirMoveRandomizer)
						{
							currentPivot = pivots[9]; //top left
						}else{
							currentPivot = pivots[4]; //back top
						}
					} else {
						if(dirMoveRandomizer)
						{
							currentPivot = pivots[10];//bottom right
						}else{
							currentPivot = pivots[3]; //fron bottom
						}
					}
				} else {
					if(diff.z > 0)
					{
						if(dirMoveRandomizer)
						{
							currentPivot = pivots[0];//front-top
						}else{
							currentPivot = pivots[2];//frontright
						}
					} else {
						if(dirMoveRandomizer)
						{
							currentPivot = pivots[7];//back bottom
						}else{
							currentPivot = pivots[5];//back left
						}
					}
				}
				rotRemainder += 90;
				pivot = transform.position+currentPivot.pivot;
			}
		}
	}
}
