using UnityEngine;
using System.Collections;

public class GestureHandle : MonoBehaviour {


	private bool TouchIsRotate;
	void OnFingerDown(FingerDownEvent e) { /* your code here */ 
		GameObject obj = GameObject.Find ("Map");

		if(obj!=null)
		obj.SendMessage ("OnFingerDown", e, SendMessageOptions.DontRequireReceiver);
//		Vector2 pos = e.Position;
//		if (pos.x < Screen.width / 2) {
//			TouchIsRotate = true;		
//		} else {
//			TouchIsRotate=false;		
//		}
	}
	void OnSwipe(SwipeGesture gesture) { /* your code here */ 
		GameObject obj = GameObject.Find ("Map");
		if(obj!=null)
		obj.SendMessage ("OnSwipe", gesture, SendMessageOptions.DontRequireReceiver);
//		FingerGestures.SwipeDirection direction= gesture.Direction;
//		if (TouchIsRotate) {
//			if (direction == FingerGestures.SwipeDirection.a) {
//				Debug.Log ("Rotate Right");
//				HandleRotation(3);
//			}
//			if (direction == FingerGestures.SwipeDirection.b) {
//				Debug.Log ("Rotate Left");
//				HandleRotation(2);
//			}
//			if (direction == FingerGestures.SwipeDirection.c) {
//				Debug.Log ("Rotate Up");
//				HandleRotation(0);
//			}
//			if (direction == FingerGestures.SwipeDirection.d) {
//				Debug.Log ("Rotate Down");
//				HandleRotation(1);
//			}
//		}else {
//			if (direction == FingerGestures.SwipeDirection.a) {
//				Debug.Log ("Move Right");
//				HandleMove(3);
//			}
//			if (direction == FingerGestures.SwipeDirection.b) {
//				Debug.Log ("Move Left");	
//				HandleMove(2);
//			}
//			if (direction == FingerGestures.SwipeDirection.c) {
//				Debug.Log ("Move Up");
//				HandleMove(0);
//			}
//			if (direction == FingerGestures.SwipeDirection.d) {
//				Debug.Log ("Move Down");
//				HandleMove(1);
//			}
//		}
	}
}
