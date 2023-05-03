using Dushe_h.TaskSystem;
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Tilemaps;

public class RenderTask : Task
{
	public Vector2 position;
	public Color color;
	public Tile tile;

	public RenderTask() { }

	public RenderTask(Vector2 position, Color color, Tile tile)
	{
		this.position = position;
		this.color = color;
		this.tile = tile;
	}
}

public class RenderExecutor : TaskExecutor
{
	public Tilemap tilemap;

	public RenderExecutor(Tilemap tilemap)
	{
		this.tilemap = tilemap;
	}

	public override void DoTask(Task _task)
	{
		var task = (RenderTask)_task;
		var position = new Vector3Int((int)task.position.x, (int)task.position.y);

		tilemap.SetTileFlags(position, TileFlags.None);
		tilemap.SetTile(position, task.tile);
		tilemap.SetColor(position, task.color);
	}

	public override void Execute()
	{
		base.Execute();
	}
}