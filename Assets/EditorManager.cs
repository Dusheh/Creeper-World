using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EditBehaviour
{
	public GameSpace gameSpace
	{
		get { return GameSpace.instance; } 
	}

	public Vector3 GetMousePosition()
	{
		var mousePositionOnScreen = Input.mousePosition;
		mousePositionOnScreen.z = 0.1f;
		return Camera.main.ScreenToWorldPoint(mousePositionOnScreen);
	}

	public virtual void Update()
	{

	}

	public virtual void LateUpdate()
	{

	}
}

public class TerrainEdit : EditBehaviour
{
	public TerrainManager manager
	{
		get { return TerrainManager.instance; }
	}

	public Slider height;

	public override void LateUpdate()
	{
		base.LateUpdate();

		if(manager.isClick)
		{
			var mousePosition = GetMousePosition();

			var half_x = gameSpace.Width / 2;
			var half_y = gameSpace.Height / 2;

			if (mousePosition.x < -half_x
				|| mousePosition.y < -half_y
				|| half_x < mousePosition.x
				|| half_y < mousePosition.y) return;

			manager.terrain.SetHeight(Mathf.CeilToInt(mousePosition.x) + half_x - 1, Mathf.CeilToInt(mousePosition.y) + half_y - 1, (int)height.value);
		}
	}
}

public class CreeperEdit : EditBehaviour
{

}

public class EditorManager : MonoBehaviour
{
	public EditBehaviour behaviour;

	private TerrainEdit terrainEdit;
	private CreeperEdit creeperEdit;

	[Header("Menu(Left)")]

	public Button terrain;
	public Button creeper;

	[Header("Menu(Right)")]

	public GameObject terrainMenu;
	public GameObject creeperMenu;

	[Header("TerrainReference")]
	public Slider terrainHeight;
	public Text heightShow;

	public void OnHeightChanged(float value)
	{
		heightShow.text = ((int)value + 1).ToString();
	}

	public void TurnoffAll()
	{
		behaviour = null;
		terrainMenu.SetActive(false);
		creeperMenu.SetActive(false);
	}

	public void OnTerrainClick()
	{
		TurnoffAll();
		behaviour = terrainEdit;
		terrainMenu.SetActive(true);
	}

	public void OnCreeperClick()
	{
		TurnoffAll();
		behaviour = creeperEdit;
		creeperMenu.SetActive(true);
	}

	public void Update()
	{
		behaviour?.Update();
	}

	public void LateUpdate()
	{
		behaviour?.LateUpdate();
	}

	public void Awake()
	{
		TurnoffAll();
		terrainEdit = new();
		creeperEdit = new();
		terrainHeight.onValueChanged.AddListener(OnHeightChanged);
		OnHeightChanged(0);
		terrainEdit.height = terrainHeight;

	}
}
