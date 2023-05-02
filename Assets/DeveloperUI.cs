using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeveloperUI : MonoBehaviour
{
    public GameSpace gamespace;
    
    private void OnGUI()
    {
        if (GUI.Button(new Rect(0, 0, 160, 30), "Create A Fiuld"))
        {
			gamespace.simulation.AddCreeper(5, 5, 2000_000000, false);
        }
		gamespace.simulation.AddCreeper(5, 5, 0_100000, false);
        GUI.Label(new Rect(0, 30, 300, 30), string.Format("Creeper Total: {0}", gamespace.simulation.CreeperTotal));
    }
}
