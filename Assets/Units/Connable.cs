using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public partial class UnitManager : MonoBehaviour
{
	private bool connectable = true;

	public bool Connectable { get { return connectable; } }

	public float connectDistance = 8;

	public void Connect(UnitManager unit)
	{
		if (Vector3.Distance(unit.transform.position, transform.position) < connectDistance)
		{
			if (Edge.FindEdge(unit.transform) != null) return;

			GameObject edgeGo = Instantiate(Resources.Load<GameObject>("Edge"), null);
			var _edge = edgeGo.GetComponent<EdgeManager>();
			Edge edge = new Edge(_edge, unit.transform, transform);
		}
	}

	public void OnDestroy()
	{
		var edge = Edge.FindEdge(transform);
		if(edge != null)
		{
			DestroyImmediate(edge.edge.gameObject);
			Edge.edges.Remove(edge);
		}
		units.Remove(this);
	}
}
