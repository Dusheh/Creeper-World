using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EdgeManager : MonoBehaviour
{
	public Transform start, end;
	public UnitManager _s, _e;

	public void Awake()
	{

	}

	public void Update()
	{
		if(start==null||end==null)
		{
			Destroy(gameObject);
		}
		transform.position = (start.position + end.position) / 2;
		var _ = transform.position - end.position;
		transform.localScale = new Vector3(Vector3.Distance(start.position, end.position), 0.15f, 1);
		transform.eulerAngles = new(0, 0, Mathf.Atan2(_.y, _.x) * Mathf.Rad2Deg);
	}
}
