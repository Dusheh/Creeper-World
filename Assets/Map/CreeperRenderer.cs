using UnityEngine;
using Dushe_h.TaskSystem;
using UnityEngine.Tilemaps;
using System.Collections.Generic;
using System;

public class CreeperRenderer : MonoBehaviour
{
	public RenderExecutor executor;

	public Color CreeperColor, AntiCreeperColor;

	public CreeperSimulation simulation;

	public Tilemap tilemap;

	public Tile tileBase;

	public void Awake()
	{
		executor = new RenderExecutor(tilemap);
		TaskSystem.Add(executor);
	}

	public void Update()
	{
		executor.Execute();
	}
}