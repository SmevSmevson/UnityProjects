using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class Diffuse_Normal_Emission_Multi_Cutout_Manager : MonoBehaviour {

	public Transform[] transforms;
	public Material[] multiCutoutMats; 
	// Use this for initialization
	[HideInInspector]
	public Vector4[] positions;

	void Start () {

		positions = new Vector4[transforms.Length];
		//set how many transforms to check in the shaders
		for (int i = 0; i < multiCutoutMats.Length; i++) 
		{
			multiCutoutMats[i].SetInt("_TransformCount", transforms.Length);
		}
		//get the transforms and put them into a vector4 array for the shader
		for (int i = 0; i < transforms.Length; i++) 
		{
			positions[i] = new Vector4(transforms[i].position.x,transforms[i].position.y,transforms[i].position.z, 1f);
		}
	}
	
	// Update is called once per frame
	void Update () {

		//get the updated transforms and put them into a vector4 array for the shader
		for (int i = 0; i < transforms.Length; i++) 
		{
			positions[i] = new Vector4(transforms[i].position.x,transforms[i].position.y,transforms[i].position.z, 1f);
		}
		//pass the new positions into the shader
		for (int i = 0; i < multiCutoutMats.Length; i++) 
		{
			multiCutoutMats[i].SetVectorArray("_Positions", positions);
		}
	}
}
