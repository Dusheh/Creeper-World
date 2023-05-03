using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BlasterManager : WeaponManager
{
	[Space]
	public GunManager gunManager;

	public AudioSource source;

	public AudioClip gunSound;

	public void AttackCreeper()
	{
		if (!Fireable()) return;

		var cannonPosition = new Vector2Int((int)transform.position.x + gameSpace.Width / 2, (int)transform.position.y + gameSpace.Height / 2);
		var position = simulation.FindNearestCreeper(cannonPosition.x, cannonPosition.y, fireRange);
		if (position.x == int.MaxValue || position.y == int.MaxValue) return;

		gunManager.AttackTo(position);

		//var temp = (int)(damageRange / 2);
		var temp = (int)(damageRange);
		// ∑∂Œß…À∫¶
		for (int i = position.x - temp; i < position.x + temp; i++)
		{
			for (int j = position.y - temp; j < position.y + temp; j++) 
			{
				if (Vector2Int.Distance(new Vector2Int(i,j), position) < damageRange && simulation.GetCreeper(i,j) > 0)
				{
					simulation.AddCreeper(i, j, -damageEffect);
					if (simulation.GetCreeper(i, j) < 0) simulation.SetCreeper(i, j, 0);
				}
			}
		}

		source.clip = gunSound;
		source.Play();
	}

	public new void FixedUpdate()
	{
		base.FixedUpdate();
		AttackCreeper();
	}
}
