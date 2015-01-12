using UnityEngine;
using System.Collections;

public class ChangeProspect : MonoBehaviour {
	public float AngleUnit=1.0f;
	private int TotalTimes;
	private int Count=0;
	private int Direction = 0;
	private bool IsRotating=false;


	private Vector3 DirectionUp=new Vector3(1.0f,0,0);

	private Vector3 DirectionRight=new Vector3(0,-1.0f,0);


	// Use this for initialization
	void Start () {
		TotalTimes =(int)( 90 / AngleUnit);
	}
	
	// Update is called once per frame
	void Update () {

		if (IsRotating) {
			RotateWorld();		
		} else {
			if (Input.GetKeyDown (KeyCode.W)) {
				//transform.Rotate(new Vector3(0,-90.0f,0));	
				IsRotating=true;
				Direction=0;
				CorrectingDirection();
				//GameObject.Find("Main Camera").GetComponent<Camera>().enabled=false;
			}
			if (Input.GetKeyDown (KeyCode.S)) {
				//transform.Rotate(new Vector3(0,-90.0f,0));
				IsRotating=true;
				Direction=1;
				CorrectingDirection();
				//Camera.main.enabled=false;
			}
			if (Input.GetKeyDown (KeyCode.A)) {
				//transform.Rotate(new Vector3(-90.0f,0,0));
				IsRotating=true;
				Direction=2;
				CorrectingDirection();
				//Camera.main.enabled=false;
			}
			if (Input.GetKeyDown (KeyCode.D)) {
				//transform.Rotate(new Vector3(90.0f,0,0));
				IsRotating=true;
				Direction=3;
				CorrectingDirection();
				//Camera.main.enabled=false;
			}		
		}
	}
	void RotateWorld(){
		switch (Direction) {
		case 0:
			transform.Rotate(AngleUnit*DirectionUp);
			break;
		case 1:
			transform.Rotate(-AngleUnit*DirectionUp);	
			break;
		case 2:
			transform.Rotate(-AngleUnit*DirectionRight);	
			break;
		case 3:
			transform.Rotate(AngleUnit*DirectionRight);	
			break;
		}
		Count++;
		if (TotalTimes ==Count) {
			IsRotating=false;
			Count=0;
		}
	}
	void CorrectingDirection(){
		float[] tmp=new float[3];
		switch (Direction) {
		case 0:
		case 1:
			tmp[0]=DirectionRight.x;
			tmp[1]=DirectionRight.y;
			tmp[2]=DirectionRight.z;
			if(DirectionUp.x!=0){
				DirectionRight.y=-tmp[2];
				DirectionRight.z=tmp[1];
				DirectionRight*=DirectionUp.x;
			}else if(DirectionUp.y!=0){
				DirectionRight.z=-tmp[0];
				DirectionRight.x=tmp[2];
				DirectionRight*=DirectionUp.y;
			}else if(DirectionUp.z!=0){
				DirectionRight.x=-tmp[1];
				DirectionRight.y=tmp[0];
				DirectionRight*=DirectionUp.z;
			}
			if(Direction==0)DirectionRight*=-1.0f;
			break;
		case 2:
		case 3:
			tmp[0]=DirectionUp.x;
			tmp[1]=DirectionUp.y;
			tmp[2]=DirectionUp.z;
			if(DirectionRight.x!=0){
				DirectionUp.y=-tmp[2];
				DirectionUp.z=tmp[1];
				DirectionUp*=DirectionRight.x;
			}else if(DirectionRight.y!=0){
				DirectionUp.z=-tmp[0];
				DirectionUp.x=tmp[2];
				DirectionUp*=DirectionRight.y;
			}else if(DirectionRight.z!=0){
				DirectionUp.x=-tmp[1];
				DirectionUp.y=tmp[0];
				DirectionUp*=DirectionRight.z;
			}
			if(Direction==3)DirectionUp*=-1.0f;
			break;
		}
		//Debug.Log ("Right:"+DirectionRight.ToString()+",Up:"+DirectionUp.ToString());

	}
}
