using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Edge
{
	public EdgeManager edge = null;

	public static List<Edge> edges = new List<Edge>();

	public Edge(EdgeManager e, Transform t1, Transform t2)
	{
		edge = e;
		edge.start = t1; edge.end = t2;
		edge._s = t1.GetComponent<UnitManager>();
		edge._e = t2.GetComponent<UnitManager>();
		edges.Add(this);
	}

	public bool hasBind(Transform t)
	{
		if (edge.start == t || edge.end == t) return true;
		return false;
	}

	public static Edge FindEdge(Transform t)
	{
		foreach(var edge in edges)
		{
			if(edge.hasBind(t)) return edge;
		}
		return null;
	}

	public static void Update()
	{
		List<Edge> copy = new(edges);
		foreach (Edge e in edges)
		{
			if(e.edge == null || e.edge.start == null || e.edge.end == null)
			{
				copy.Remove(e);
				continue;
			}
			var edge = e.edge;
			var distance = Mathf.Max(edge._s.connectDistance, edge._e.connectDistance);

			if (Vector3.Distance(edge.start.position, edge.end.position) > distance)
			{
				GameObject.DestroyImmediate(edge.gameObject);
				copy.Remove(e);
			}
		}
		edges = copy;
	}
}
