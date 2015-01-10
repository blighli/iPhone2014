using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class TestScript : MonoBehaviour {
	private float screenwidth,screenheight;
	private bool IsRotate=false;
	// Use this for initialization
	void Start () {
		screenwidth = Screen.width;
		screenheight = Screen.height;
	}
	void OnFingerMove(FingerMotionEvent e) { /* your code here */ }
	void OnFingerStationary(FingerMotionEvent e) { /* your code here */ }
	void OnFingerUp(FingerUpEvent e) { /* your code here */ }
	void OnFingerDown(FingerDownEvent e) { /* your code here */ 
		Vector2 pos = e.Position;
		if (pos.x < screenwidth / 2) {
			IsRotate = true;		
		} else {
			IsRotate=false;		
		}
	}
	void OnSwipe(SwipeGesture gesture) { /* your code here */ 

		FingerGestures.SwipeDirection direction= gesture.Direction;
		if (IsRotate) {
			if (direction == FingerGestures.SwipeDirection.a) {
				Debug.Log ("Rotate Right");		
			}
			if (direction == FingerGestures.SwipeDirection.b) {
				Debug.Log ("Rotate Left");		
			}
			if (direction == FingerGestures.SwipeDirection.c) {
				Debug.Log ("Rotate Up");		
			}
			if (direction == FingerGestures.SwipeDirection.d) {
				Debug.Log ("Rotate Down");
			}
		}else {
			if (direction == FingerGestures.SwipeDirection.a) {
				Debug.Log ("Move Right");		
			}
			if (direction == FingerGestures.SwipeDirection.b) {
				Debug.Log ("Move Left");		
			}
			if (direction == FingerGestures.SwipeDirection.c) {
				Debug.Log ("Move Up");		
			}
			if (direction == FingerGestures.SwipeDirection.d) {
				Debug.Log ("Move Down");		
			}
		}
	}
	// Update is called once per frame
	void Update () {
		if (Input.touchCount > 0) {
			print(Input.touchCount);		
		}

	}
}
