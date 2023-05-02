using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CannonManager : WeaponManager
{
	public void AttackCreeper()
	{
		var cannonPosition = new Vector2Int((int)transform.position.x + gameSpace.Width / 2, (int)transform.position.y + gameSpace.Height / 2);
		var position = simulation.FindNearestCreeper(cannonPosition.x, cannonPosition.y, fireRange);
		if (position.x == int.MinValue || position.y == int.MinValue) return;

		var temp = (int)(damageRange / 2);
		// ∑∂Œß…À∫¶
		for (int i = position.x - temp; i < position.x + temp; i++)
		{
			for (int j = position.y - temp; j < position.y + temp; j++) 
			{
				if (Vector2Int.Distance(new Vector2Int(i,j), position) < damageRange)
				{
					simulation.AddCreeper(i, j, -damageEffect);
					if (simulation.GetCreeper(i, j) < 0) simulation.SetCreeper(i, j, 0);
				}
			}
		}
	}

	public void Awake()
	{

	}

	public void FixedUpdate()
	{
		HealthDamage();
		AttackCreeper();
	}
}
