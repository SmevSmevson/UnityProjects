using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(CutoutManager))]
public class CutoutManagerEditor : Editor {

	protected virtual void OnSceneGUI()
	{
		CutoutManager cutoutManager = (target as CutoutManager);

		EditorGUI.BeginChangeCheck();
		Handles.DrawLine(cutoutManager.startPoint.position,cutoutManager.endPoint.position);
		float newStartRadius = Handles.RadiusHandle(Quaternion.identity, cutoutManager.startPoint.position, cutoutManager.maxRadius);
		float newEndRadius = Handles.RadiusHandle(Quaternion.identity, cutoutManager.endPoint.position, newStartRadius);
		Vector3 newStartPosition = Handles.PositionHandle(cutoutManager.startPoint.position, Quaternion.identity);
		Vector3 newEndPosition = Handles.PositionHandle(cutoutManager.endPoint.position, Quaternion.identity);

		if (EditorGUI.EndChangeCheck())
		{
			Undo.RecordObject(target, "Changed position And Radius");

			cutoutManager.startPoint.position = newStartPosition;
			cutoutManager.endPoint.position = newEndPosition;
			cutoutManager.maxRadius = newStartRadius = newEndRadius;
		}

	}
}
