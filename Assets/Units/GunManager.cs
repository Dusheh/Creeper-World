using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GunManager : MonoBehaviour
{
	public void AttackTo(Vector2Int position)
	{
		position -= new Vector2Int(GameSpace.instance.Width, GameSpace.instance.Height) / 2;
		transform.eulerAngles = new Vector3(0, 0, Mathf.Rad2Deg * Mathf.Atan2(position.y - transform.position.y, position.x - transform.position.x));
	}
}
