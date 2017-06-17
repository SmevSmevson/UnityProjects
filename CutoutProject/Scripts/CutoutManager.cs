using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class CutoutManager : MonoBehaviour {

	public Material[] cutoutMaterials;
	public Transform startPoint, endPoint;
	public bool checkCollision;
	public float subtractDistance; //take away from distance so raycast doesn't hit the targets collider
	public AnimationCurve changeRadius;
	[Range(0f,5f)]
	public float maxRadius = 1f;

	float t = 1f;

	// Update is called once per frame
	void Update () {

		if(checkCollision)
		{
			Debug.DrawLine(startPoint.position, endPoint.position, Color.red);

			if(Physics.Raycast(startPoint.position, endPoint.position - startPoint.position, Vector3.Distance(endPoint.position, startPoint.position) - subtractDistance))
			{
				t = Mathf.Clamp01 (t+Time.deltaTime);
			}
			else
			{
				t = Mathf.Clamp01 (t-Time.deltaTime);
			}

		}

		foreach(Material mat in cutoutMaterials)
		{
			mat.SetVector("_StartPosition", startPoint.position);
			mat.SetVector("_EndPosition", endPoint.position);
			mat.SetFloat("_Radius", changeRadius.Evaluate(t)*maxRadius);
		}
	}
}
