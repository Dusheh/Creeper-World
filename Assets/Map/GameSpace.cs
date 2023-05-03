using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameSpace : MonoBehaviour
{
    public CreeperRenderer creeperRenderer;

	public CreeperSimulation simulation;

	public TerrainManager Terrain { get { return TerrainManager.instance; } }

	public static GameSpace instance;

	private int width, height;

	public int Width
	{
		get { return width; }
	}
	public int Height
	{
		get { return height; }
	}

	public float FlowRate 
	{
		get
		{
			return simulation.FlowRate;
		}
		set
		{
			simulation.FlowRate = value;
		}
	}

	public float flowRate;

	public void Awake()
	{
		instance = this;
		width = 32;
		height = 32;
		simulation = new CreeperSimulation(width, height);
		simulation.FlowRate = 0.08f;
		creeperRenderer.simulation = simulation;
	}

	public void FixedUpdate()
	{
		FlowRate = flowRate;
		simulation.Update();
		simulation.Render(creeperRenderer);

		Edge.Update();
	}
}
