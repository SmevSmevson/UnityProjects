using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovePingPong : MonoBehaviour {

	public float scale = 1f;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		this.transform.position = new Vector3(this.transform.position.x, this.transform.position.y, Mathf.Sin(Time.time) * scale);
	}
}
