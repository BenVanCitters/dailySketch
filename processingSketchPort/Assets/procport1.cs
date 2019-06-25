using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class procport1 : MonoBehaviour {

    int _oldHWCount = -1;
    int _oldHHCount = -1;
    public int HalfWidthCount = 5;
    public int HalfHeightCount= 5;
    public float size = 2;
    private GameObject[,] cubes;
    
    // Use this for initialization
    void Start () {
        makeCubes();

    }
	
    private void makeCubes()
    {
        if(_oldHHCount == HalfHeightCount && _oldHWCount == HalfWidthCount)
        {
            return;
        }
        Debug.Log("rebuilding cunes!");
        if (cubes != null)
        {
            foreach (GameObject g in cubes)
            {
                GameObject.Destroy(g);
            }
        }
        cubes = new GameObject[2 * HalfWidthCount, 2 * HalfHeightCount];
        for (int i =0; i < HalfWidthCount*2; i++)
        {
            for(int j = 0; j < HalfHeightCount*2; j++)
            {
                cubes[i,j] = GameObject.CreatePrimitive(PrimitiveType.Cube);
                cubes[i, j].transform.SetParent(transform);
            }
        }
        _oldHHCount = HalfHeightCount;
        _oldHWCount = HalfWidthCount;
    }

	// Update is called once per frame
	void Update () {
        makeCubes();
        float tm = Time.realtimeSinceStartup;
        float s = (1 + Mathf.Sin(tm * .06f)) / 2.0f;
        for (int i = -_oldHWCount; i < _oldHWCount; i++)
        {
            for (int j = -_oldHHCount; j < _oldHHCount; j++)
            {
                float i_s = 2 * Mathf.Sin(.3f * tm + i / 23.0f);
                float j_s = 1.5f * Mathf.Sin(0.7f * tm + j / 29.0f);
                float j_i_s = 2.5f * Mathf.Sin(0.2f * tm - i * .5f + j / 13.0f);
                i_s *= s;
                j_s *= s;
                j_i_s *= s;
                int indx = i + _oldHWCount;
                int jndx = j + _oldHHCount;
                cubes[indx, jndx].transform.position = Vector3.zero;
                cubes[indx, jndx].transform.localScale = Vector3.one;

                cubes[indx, jndx].transform.rotation = Quaternion.identity;
                //rotateX
                cubes[indx, jndx].transform.Rotate(new Vector3(tm * 0.15f + i_s,0,0)* Mathf.Rad2Deg);
                //rotateY
                cubes[indx, jndx].transform.Rotate(new Vector3(0, tm * 0.2f + j_i_s, 0)* Mathf.Rad2Deg);
                //rotateZ
                cubes[indx, jndx].transform.Rotate(new Vector3(0,0, tm * 0.06f + j_s)* Mathf.Rad2Deg);
                //translate
                cubes[indx, jndx].transform.Translate(new Vector3(size * 1.3f * i,
                  size * 1.3f * j, 0));
                cubes[indx, jndx].transform.localScale = new Vector3(size, size, size);
            }
        }
    }
}
