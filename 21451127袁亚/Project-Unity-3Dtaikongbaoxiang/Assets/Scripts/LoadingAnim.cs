using UnityEngine;
using System.Collections;

public class LoadingAnim : MonoBehaviour {
	void AnimFinishEvent(){
		gameObject.GetComponent<FreeRotate> ().enabled = true;
		gameObject.GetComponent<Animator> ().enabled = false;
	}
}
