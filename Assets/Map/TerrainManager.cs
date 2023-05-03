using Dushe_h.TaskSystem;
using UnityEngine;
using UnityEngine.Tilemaps;

[RequireComponent(typeof(BoxCollider2D))]
public class TerrainManager : UnityEngine.MonoBehaviour
{
	public static TerrainManager instance;

	public GameSpace gameSpace { get { return GameSpace.instance; } }

	public class Terrain
	{
		private int[,] _data;

		private int width, height;

		public int[,] Height { get { return _data; } }

		public Terrain(int width, int height)
		{
			this.width = width;
			this.height = height;
			_data = new int[width, height];
		}

		public void SetHeight(int x,int y, int height)
		{
			Debug.LogFormat("{0},{1}:{2}", x, y, height);

			if (x < 0 || y < 0 || x >= width || y >= height)	
			_data[x,y] = height * 1_000000;

			instance.ReDraw = true;
		}
	}

	public Terrain terrain;

	public Tilemap tilemap;

	public Tile[] terrainTiles;

	public RenderExecutor executor;

	public bool ReDraw = true;

	public void Awake()
	{
		instance = this;
		executor = new RenderExecutor(tilemap);
		terrain = new Terrain(gameSpace.Width, gameSpace.Height);
		TaskSystem.Add(executor);

		for (int i = 0; i <= 12; i++)
			for (int j = 0; j <= 12; j++)
			{
				if (i == 6 && j == 6) continue;
				terrain.SetHeight(i, j, Mathf.Clamp(4 - (int)Vector2.Distance(Vector2.one * 6, new Vector2(i, j)), 0, 4));
			}

		GetComponent<BoxCollider2D>().size = new(32, 32);
	}

	public void FixedUpdate()
	{
		isClick = false;

		if (Input.GetKeyDown(KeyCode.Space)) UnitManager.selectedUnit = null;

		if (!ReDraw) return;
		Vector2Int position = new();
		var tempx = gameSpace.Width / 2;
		var tempy = gameSpace.Height / 2;
		for (int i = 0; i < gameSpace.Width; i++)
		{
			for (int j = 0; j < gameSpace.Height; j++)
			{
				position.x = i - tempx;
				position.y = j - tempy;
				Tile tile;
				if (terrainTiles.Length > terrain.Height[i, j] / 1_000000) tile = terrainTiles[terrain.Height[i, j] / 1_000000];
				else tile = terrainTiles[0];
				executor.tasks.Add(new RenderTask(position, Color.white, tile));
			}
		}
		ReDraw = false;
	}

	public bool isClick;

	public void OnMouseDrag()
	{
		isClick = true;
		//var screenPosition = Camera.main.WorldToScreenPoint(transform.position);
		var mousePositionOnScreen = Input.mousePosition;
		mousePositionOnScreen.z = 0.1f;
		var mousePositionInWorld = Camera.main.ScreenToWorldPoint(mousePositionOnScreen);

		var target = new Vector3(Mathf.Ceil(mousePositionInWorld.x) - 0.5f, Mathf.Ceil(mousePositionInWorld.y) - 0.5f);

		if (UnitManager.selectedUnit == null) return;
		UnitManager.selectedUnit.SetMoveTarget(target);
	}
}
