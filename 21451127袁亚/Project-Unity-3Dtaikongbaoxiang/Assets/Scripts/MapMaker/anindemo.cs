using UnityEngine;
using System.Collections;

public class anindemo : MonoBehaviour {
	public Animation anin;
	// Use this for initialization
	void Start () {
		//GetComponent<Animation> ().Play ();
		//GetComponent<Animation> ().PlayQueued ("ani1");
		GetComponent<Animation> ().CrossFade ("ani1");

	}
	
	// Update is called once per frame
	void Update () {
		//GetComponent<Animation> ().Play ();
	}
}
