using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EmitterManager : MonoBehaviour
{
	public GameSpace gameSpace
	{
		get { return GameSpace.instance; }
	}
	public Vector2Int GetPosition()
	{
		return new Vector2Int(Mathf.CeilToInt(transform.position.x) + gameSpace.Width / 2 - 1, Mathf.CeilToInt(transform.position.y) + gameSpace.Height / 2 - 1);
	}

	public float EmitAmt;
	public float EmitDelay;
	public float StartDelay;

	private float timer;

	public void Emission()
	{
		var Position = GetPosition();
		gameSpace.simulation.AddCreeper(Position.x, Position.y, (int)(EmitAmt * 1_000000));
	}

	public void FixedUpdate()
	{
		timer += Time.deltaTime;
		if(StartDelay>0)
		{
			StartDelay -= Time.deltaTime;
			return;
		}
		if (EmitDelay > timer) return;

		timer = 0;
		Emission();

	}
}
