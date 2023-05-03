using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public partial class UnitManager : MonoBehaviour
{
	public static UnitManager selectedUnit;
	private float unitHeight = 0;

	private Vector3 MoveTarget;
	public float moveSpeed;
	public bool Moving;

	[Header("Animation")]
	public float moveZoom = 0.02f;
	public float zoomSpeed = 10;

	public void Move()
	{
		if (transform.position == MoveTarget) Moving = false;
		else Moving = true;

		if (Moving)
		{
			unitHeight = Mathf.MoveTowards(unitHeight, 5, Time.deltaTime * zoomSpeed);

			var temp = transform.localScale;
			temp.x = temp.y = unitHeight * moveZoom + 1;
			transform.localScale = temp;

			if (unitHeight != 5) return;
			transform.position = Vector3.MoveTowards(transform.position, MoveTarget, moveSpeed * Time.deltaTime);

			foreach (var unit in units)
			{
				if (unit.connectable && unit != this)
				{
					Connect(unit);
				}
			}
		}
		else
		{
			if (unitHeight > 0)
			{
				unitHeight = Mathf.MoveTowards(unitHeight, 0, Time.deltaTime * zoomSpeed);

				var temp = transform.localScale;
				temp.x = temp.y = unitHeight * moveZoom + 1;
				transform.localScale = temp;
			}
		}
	}

	public void SetMoveTarget(Vector3 moveTarget)
	{
		MoveTarget = moveTarget;
	}

	public void OnMouseDown()
	{
		selectedUnit = this;
	}
}
