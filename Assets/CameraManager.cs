using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraManager : MonoBehaviour
{
	public new Camera camera;

	public float speed;

	public void Awake()
	{
		camera = GetComponent<Camera>();
	}

	public void FixedUpdate()
	{
		if (Input.GetKey(KeyCode.W)) transform.position += Vector3.up * Time.deltaTime * speed;
		if (Input.GetKey(KeyCode.S)) transform.position -= Vector3.up * Time.deltaTime * speed;
		if (Input.GetKey(KeyCode.A)) transform.position += Vector3.left * Time.deltaTime * speed;
		if (Input.GetKey(KeyCode.D)) transform.position -= Vector3.left * Time.deltaTime * speed;
	}
}
