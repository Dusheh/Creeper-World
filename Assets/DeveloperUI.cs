using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeveloperUI : MonoBehaviour
{
    public GameSpace gamespace;

    public bool editTerrain = false;

    public string editx, edity, editv;

    public float CreeperLimit;

    private void OnGUI()
    {
        if (GUI.Button(new Rect(0, 0, 160, 30), "Create A Fiuld"))
        {
			gamespace.simulation.AddCreeper(6, 6, (int)(1_000000 * CreeperLimit), false);
        }
        if(GUI.Button(new Rect(160,0,160,30),"Create a AC"))
        {
            gamespace.simulation.AddCreeper(26, 26, (int)(-1_000000 * CreeperLimit), false);
        }
        //editTerrain = GUI.Toggle(new Rect(160, 0, 100, 30), editTerrain, "EditTerrain");
        if (editTerrain)
        {
            editx = GUI.TextArea(new Rect(0, 30, 120, 30), editx);
            edity = GUI.TextArea(new Rect(120, 30, 120, 30), edity);
            editv = GUI.TextArea(new Rect(240, 30, 120, 30), editv);
            if(GUI.Button(new Rect(360,30,120,30),"Create"))
            {
                gamespace.Terrain.terrain.SetHeight(Convert.ToInt32(editx), Convert.ToInt32(edity), Convert.ToInt32(editv));
            }
        }

        //gamespace.simulation.AddCreeper(5, 5, 0_100000, false);
        GUIStyle style = new();
        style.fontSize = 36;
        style.normal.textColor = Color.black;
        GUI.Label(new Rect(0, 30, 300, 30), string.Format("Creeper Total: {0}", gamespace.simulation.CreeperTotal), style);
    }
}
