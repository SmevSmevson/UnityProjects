using UnityEngine;

using UnityEditor;

public class LightMapMenu : MonoBehaviour

{

	// The menu item.

	[MenuItem ("MyCustomBake/MakeRealtimeEmissive")]

	static void Bake ()

	{

		// Find all objects with the tag <Emissive_to_baked>

		// We have to set the tag “Emissive_to_baked” on each GO to be baked.

		GameObject[] _emissiveObjs = Selection.gameObjects;//GameObject.FindGameObjectsWithTag("Emissive_to_baked");
			
		// Then, by each object, set the globalIllumiationFlags to BakedEmissive.

		foreach (GameObject tmpObj in _emissiveObjs)

		{

			Material tmpMaterial = tmpObj.GetComponent<Renderer> ().sharedMaterial;

			tmpMaterial.globalIlluminationFlags = MaterialGlobalIlluminationFlags.RealtimeEmissive;

		}

		// Bake the lightmap.

		Lightmapping.Bake ();

	}

}