public class TerrainManager : UnityEngine.MonoBehaviour
{
	public static TerrainManager instance;

	public GameSpace gameSpace { get { return GameSpace.instance; } }

	public class Terrain
	{
		private int[,] _data;

		private int width, height;

		public Terrain(int width, int height)
		{
			this.width = width;
			this.height = height;
			_data = new int[width, height];
		}

		public void SetHeight(int x,int y, int height)
		{
			if (x < 0 || y < 0 || x >= width || y >= height)	
			_data[x,y] = height;
		}
	}

	public Terrain terrain;

	public void Awake()
	{
		instance = this;
	}
}
