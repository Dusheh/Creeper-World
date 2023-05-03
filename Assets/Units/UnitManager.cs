using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(BoxCollider2D))]
public partial
	class UnitManager : MonoBehaviour
{
	public static List<UnitManager> units = new();

	public GameSpace gameSpace { get { return GameSpace.instance; } }
	public CreeperSimulation simulation { get { return gameSpace.simulation; } }
	public Vector2Int gamePosition { get { return new Vector2Int((int)transform.position.x + gameSpace.Width / 2, (int)transform.position.y + gameSpace.Height / 2); } }

	public float Health;
	public float Ammo;

	public void HealthDamage()
	{
		if(simulation.GetCreeper(gamePosition.x,gamePosition.y) > 0)
		{
			Health -= 0.5f * Time.deltaTime;
		}
		if(Health < 0)
		{
			Destroy(gameObject);
			units.Remove(this);
			Edge.edges.Remove(Edge.FindEdge(transform));
		}
	}

	public void Awake()
	{
		MoveTarget = transform.position;
		units.Add(this);
	}

	public void Update()
	{
		Move();
	}

	public void FixedUpdate()
	{
		HealthDamage();
	}
}

public class WeaponManager : UnitManager
{
	public float fireRange = 5;
	public float damageRange = 5;
	public int damageEffect = 1_000000;
	public float fireRate = 0.2f;

	private float fireTimer = 0;

	//Call when need to fire(Only in calling)
	public bool Fireable()
	{
		if (fireTimer < fireRate) return false;
		else
		{
			fireTimer = 0;
			return true;
		}
	}

	public new void FixedUpdate()
	{
		base.FixedUpdate();

		fireTimer += Time.deltaTime;
	}
}