using System;
using UnityEngine;

public class GameException
{
    public class LessThanZero : Exception
    {
        public LessThanZero(string message) : base(message)
        {
        }
    }

    public class NotAOdd : Exception
    {
        public NotAOdd(string message) : base(message)
        {
        }
    }
}

public class CreeperSimulation
{
    private int[,] _data;

    private int width, height;

    private ulong creeperTotal;

    public ulong CreeperTotal { get { return creeperTotal; } }

    [Range(0, 0.25f)]
    private float flowRate;

    public float FlowRate
    {
        get { return flowRate; }
        set { flowRate = value; }
    }

    public CreeperSimulation(int width, int height)
    {
        if (width < 0 || height < 0) throw new GameException.LessThanZero("Width or height less than 0 in creating map.");
        if (width % 2 == 1 || height % 2 == 1) throw new GameException.NotAOdd("One of map's dimension not a odd.");
        this.width = width;
        this.height = height;

        _data = new int[width, height];
    }

    public void AddCreeper(int x, int y, int value, bool limitAsValue = false)
    {
        if (x < 0 || y < 0 || x >= width || y >= height) return;

        if (limitAsValue && _data[x, y] < value)
        {
            _data[x, y] += value;
            if (_data[x, y] > value) _data[x, y] = value;
        }
        else _data[x, y] += value;
    }

    public int GetCreeper(int x, int y)
	{
		if (x < 0 || y < 0 || x >= width || y >= height) return 0;

		return _data[x, y];
    }

    public void SetCreeper(int x, int y, int value)
	{
		if (x < 0 || y < 0 || x >= width || y >= height) return;

		_data[x, y] = value;
    }

    public Vector2Int FindNearestCreeper(int x, int y, float maxDistance)
    {
        if (x < 0 || y < 0 || x >= width || y >= height) return new Vector2Int(int.MinValue, int.MinValue);

        var result = new Vector2Int(int.MaxValue, int.MaxValue);
        var position = new Vector2Int(x, y);
        var result_distance = Vector2Int.Distance(result, position);

        for (int i = 0; i < width; i++)
        {
            for (int j = 0; j < height; j++)
            {
                var target = new Vector2Int(i, j);
                var distance = Vector2Int.Distance(position, target);
                if (distance > maxDistance) continue;
                if (_data[i, j] <= 0) continue;

                if(distance < result_distance)
                {
                    result = target;
                    result_distance = distance;
                }
            }
        }
        return result;
    }

    public extern Vector2Int FindDeepestCreeper(int x, int y, float maxDistance);

    public void Update()
    {
        var DataClone = new int[width, height];
        int flowTotal, flowTemp;
        for (int i = 0; i < width; i++)
        {
            for (int j = 0; j < height; j++)
            {
                flowTotal = 0;
                flowTemp = (int)(_data[i, j] * flowRate);
                if (i > 0)
                {
                    if (true || _data[i - 1, j] < _data[i, j])
                    {
                        DataClone[i - 1, j] += flowTemp;
                        flowTotal += flowTemp;
                    }
                }
                if (i < width - 1)
                {
                    if (true || _data[i + 1, j] < _data[i, j])
                    {
                        DataClone[i + 1, j] += flowTemp;
                        flowTotal += flowTemp;
                    }
                }
                if (j > 0)
                {
                    if (true || _data[i, j - 1] < _data[i, j])
                    {
                        DataClone[i, j - 1] += flowTemp;
                        flowTotal += flowTemp;
                    }
                }
                if (j < height - 1)
                {
                    if (true || _data[i, j + 1] < _data[i, j])
                    {
                        DataClone[i, j + 1] += flowTemp;
                        flowTotal += flowTemp;
                    }
                }
                DataClone[i, j] += _data[i, j] - flowTotal;

            }
        }
        creeperTotal = 0;

        for (int i = 0; i < width; i++)
        {
            for (int j = 0; j < height; j++)
            {
                creeperTotal += (ulong)DataClone[i, j];
            }
        }
        _data = DataClone;
    }

    public void Render(CreeperRenderer renderer)
    {
        Vector2Int position = Vector2Int.zero;

        for(int i = 0; i < width; i++)
        {
            for(int j = 0; j < height; j++)
            {
                position.x = i - width / 2;
                position.y = j - height / 2;

                if (_data[i, j] == 0)
                {
                    renderer.executor.tasks.Add(new CreeperRenderer.RenderTask(position, Color.white));
                }
                else if (_data[i, j] > 0)
                {
                    renderer.executor.tasks.Add(
                        new CreeperRenderer.RenderTask(
                            position,
                            renderer.CreeperColor * Mathf.Clamp(_data[i, j], 0.0f, 20000000.0f) / 1000000.0f)
                        );
                }
            }
        }
    }
}
