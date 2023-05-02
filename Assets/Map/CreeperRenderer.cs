using UnityEngine;
using Dushe_h.TaskSystem;
using UnityEngine.Tilemaps;
using System.Collections.Generic;
using System;

public class CreeperRenderer : MonoBehaviour
{
	public class RenderTask : Task
	{
		public Vector2 position;
		public Color color;

		public RenderTask(Vector2 position, Color color)
		{
			this.position = position;
			this.color = color;
		}
	}

	public class RenderExecutor : TaskExecutor
	{
		public Tilemap tilemap;

		public Tile tile;

		public RenderExecutor(Tilemap tilemap, Tile tile)
		{
			this.tilemap = tilemap;
			this.tile = tile;
			this.tasks = new List<Task>();
		}

		public override void Execute()
		{
			if (tasks.Count == 0) return;

			base.Execute(); //基类实现的排序
			foreach (RenderTask task in tasks)
			{
				var position = new Vector3Int((int)task.position.x, (int)task.position.y);
				tilemap.SetTileFlags(position, TileFlags.None);
				tilemap.SetTile(position, tile);
				tilemap.SetColor(position, task.color);
			}
			tasks.Clear();
		}

		[Obsolete]
		public async void ExecuteAsync()
		{
			await System.Threading.Tasks.Task.Run(() =>
			{
				Execute();
			});
		}
	}

	public RenderExecutor executor;

	public Color CreeperColor;

	public CreeperSimulation simulation;

	public Tilemap tilemap;

	public Tile tileBase;

	public void Awake()
	{
		executor = new RenderExecutor(tilemap, tileBase);
	}

	public void Update()
	{
		executor.Execute();
	}
}