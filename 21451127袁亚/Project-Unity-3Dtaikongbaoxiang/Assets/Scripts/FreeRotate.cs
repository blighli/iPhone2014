using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class FreeRotate : MonoBehaviour {

	public float RotateSpeed=1.0f;
	public float MoveSpeed=15.0f;

	public AudioClip moving,stop,win01,win02,rotate;

	GameObject MainPlayer;

	private float beginTime=0;
	private bool IsRotating=false;
	private bool TouchIsRotate;
	private Vector3 fwd,uwd,rwd;
	private Vector3 MoveFwd,MoveUwd,MoveRwd;
	
	private Vector3 CurrentMoveDirection;
	private Quaternion FormRotation,ToRotation;
	private bool IsMoving=false;
	private bool IsGameOver=false;
	private bool IsVictory = false;
	
	private int MoveDist=0;
	public static string TipInfo="";
	

	void OnGUI(){
		int tmpa = GameInstanceData.GetInstance.GameLevel;
		int tmpb = GameInstanceData.GetInstance.Steps;
		string s1="Level:" + (tmpa > 9 ? tmpa.ToString() : "0" + tmpa);
		string s2="Steps:" + (tmpb > 9 ? tmpb.ToString() : "0" + tmpb);
		GameInstanceData.GetInstance.SetText (GameInstanceData.GetInstance._Text_Level, s1);
		GameInstanceData.GetInstance.SetText (GameInstanceData.GetInstance._Text_Steps, s2);
		GameInstanceData.GetInstance.SetText (GameInstanceData.GetInstance._Text_Tips, TipInfo);
	}
	void GameWin(){
		Debug.Log ("You Win!");
		beginTime = Time.time;

		TipInfo = "You Win!";
		if (GameInstanceData.GetInstance.GameLevel % 2 == 0)
			audio.PlayOneShot (win01);
		else 
			audio.PlayOneShot (win02);
		GameInstanceData.GetInstance.GameLevel++;
	}
	private void GameOver(){
		Debug.Log ("You Lose!");

		TipInfo = "You Lose!";
		beginTime = Time.time;
	}
	void HandleCrashEvent(){
		IsMoving = false;
	}
	void ShowTail(bool flag){
		GameObject obj = GameObject.Find ("TrackTail");
		if (obj == null)return;
		obj.particleSystem.enableEmission = flag;
	}
	void Update() {
		if(Input.GetKey(KeyCode.R))Application.LoadLevel(GameInstanceData.GetInstance.GameScene);

		if (IsGameOver || IsVictory) {
			if(Time.time-beginTime>2f){
				TipInfo="";
				GameInstanceData.GetInstance.Steps=0;
				Application.LoadLevel(GameInstanceData.GetInstance.GameScene);
			}
		}
		if (IsMoving && !IsRotating) {
			Vector3 vecfrom=GameInstanceData.GetInstance.PlayerPos;
			Vector3 vecto=GameInstanceData.GetInstance.PlayerPos+MoveDist*CurrentMoveDirection;
			float tmp = (Time.time - beginTime) * MoveSpeed/MoveDist;
			MainPlayer.transform.localPosition=vecfrom+tmp*(vecto-vecfrom);//Vector3.Slerp(vecfrom,vecto,tmp);
			if(tmp>=1.0f){
				GameInstanceData.GetInstance.PlayerPos=vecto;
				AdjustPlayerPos();
				IsMoving=false;
				audio.Stop();
				ShowTail(false);
				if(IsVictory)GameWin();
				else if(IsGameOver)GameOver();
				else audio.PlayOneShot(stop);
			}
		}else if (IsRotating && !IsMoving) {
			float tmp = (Time.time - beginTime) * RotateSpeed;
			transform.rotation = Quaternion.Slerp (FormRotation, ToRotation, tmp);
			if (tmp >= 1.0f){
				IsRotating = false;
				update3axis();
				//AdjustPlayerPos();
			}
		} else {
			if(IsGameOver || IsVictory)return;
			if (Input.GetKeyDown (KeyCode.W)) {HandleRotation(0);} 
			if (Input.GetKeyDown (KeyCode.S)) {HandleRotation(1);} 
			if (Input.GetKeyDown (KeyCode.A)) {HandleRotation(2);} 
			if (Input.GetKeyDown (KeyCode.D)) {HandleRotation(3);} 
			if (Input.GetKeyDown (KeyCode.Z)) {HandleRotation(4);} 
			if (Input.GetKeyDown (KeyCode.X)) {HandleRotation(5);}
			if(MainPlayer==null || IsMoving){
				MainPlayer = GameObject.Find (GameInstanceData.GetInstance.PlayerMain);
				return;
			}
			if(Input.GetKeyDown(KeyCode.UpArrow)){HandleMove(0);}
			if(Input.GetKeyDown(KeyCode.DownArrow)){HandleMove(1);}
			if(Input.GetKeyDown(KeyCode.LeftArrow)){HandleMove(2);}
			if(Input.GetKeyDown(KeyCode.RightArrow)){HandleMove(3);}
		}
	}
	void OnFingerDown(FingerDownEvent e) { /* your code here */ 
		Vector2 pos = e.Position;
		if (pos.x < Screen.width / 2) {
			TouchIsRotate = true;		
		} else {
			TouchIsRotate=false;		
		}
	}
	void OnSwipe(SwipeGesture gesture) { /* your code here */ 
		
		FingerGestures.SwipeDirection direction= gesture.Direction;
		if (TouchIsRotate) {
			if (direction == FingerGestures.SwipeDirection.a) {
				Debug.Log ("Rotate Right");
				HandleRotation(3);
			}
			if (direction == FingerGestures.SwipeDirection.b) {
				Debug.Log ("Rotate Left");
				HandleRotation(2);
			}
			if (direction == FingerGestures.SwipeDirection.c) {
				Debug.Log ("Rotate Up");
				HandleRotation(0);
			}
			if (direction == FingerGestures.SwipeDirection.d) {
				Debug.Log ("Rotate Down");
				HandleRotation(1);
			}
		}else {
			if (direction == FingerGestures.SwipeDirection.a) {
				Debug.Log ("Move Right");
				HandleMove(3);
			}
			if (direction == FingerGestures.SwipeDirection.b) {
				Debug.Log ("Move Left");	
				HandleMove(2);
			}
			if (direction == FingerGestures.SwipeDirection.c) {
				Debug.Log ("Move Up");
				HandleMove(0);
			}
			if (direction == FingerGestures.SwipeDirection.d) {
				Debug.Log ("Move Down");
				HandleMove(1);
			}
		}
	}
	private void HandleMove(int direction){
		reverse3axis ();
		switch (direction) {
		case 0:
			CurrentMoveDirection=MoveUwd;
			break;
		case 1:
			CurrentMoveDirection=-MoveUwd;
			break;
		case 2:
			CurrentMoveDirection=-MoveRwd;
			break;
		case 3:
			CurrentMoveDirection=MoveRwd;
			break;
		}


		update3axis ();
		updateCurrentStatus ();
		AdjustPlayerPos ();
		MoveDist = 0;
		int i=0,j=0,k=0;
		Vector3 vec=GameInstanceData.GetInstance.GetOrthographicPos(GameInstanceData.GetInstance.CurrentStatus);
//		Debug.Log ("HandleMove()==CurrentStatus:"+GameInstanceData.GetInstance.CurrentStatus
//		           + "    OrghographicsPos:"+vec.ToString ()
//		           + "    PlayerPos:"+GameInstanceData.GetInstance.PlayerPos.ToString());

		int tmpx = GameInstanceData.GetInstance.XSize/2+1;
		int tmpy = GameInstanceData.GetInstance.YSize/2+1;
		int tmpz = GameInstanceData.GetInstance.ZSize/2+1;
		while(true){
			vec+=CurrentMoveDirection;
			i=Mathf.RoundToInt(vec.x);j=Mathf.RoundToInt( vec.y);k=Mathf.RoundToInt( vec.z);
			if(i<-tmpx || j<-tmpy || k<-tmpz || i>tmpx || j>tmpy || k>tmpz){
				IsGameOver=true;
				MoveDist+=10;
				break;
			}
			if(GameInstanceData.GetInstance.GetColliderStatus(i,j,k)!=0){
				if(GameInstanceData.GetInstance.GetColliderStatus(i,j,k)==2){
					MoveDist++;
					IsVictory=true;
				}
				break;
			}
			MoveDist++;

		}

		if (MoveDist == 0)return;
		IsMoving=true;
		beginTime = Time.time;
		GameInstanceData.GetInstance.Steps++;
		audio.PlayOneShot (moving);
		ShowTail (true);
	}
	private void AdjustPlayerPos(){
		Vector3 tmp = MainPlayer.transform.localPosition;
		//Debug.Log ("AdjustPlayerPos()==PlayerPos:======1===="+tmp.ToString());
		tmp.x = Mathf.RoundToInt (tmp.x);
		tmp.y = Mathf.RoundToInt (tmp.y);
		tmp.z = Mathf.RoundToInt (tmp.z);
		GameInstanceData.GetInstance.PlayerPos=tmp;

		//Debug.Log ("AdjustPlayerPos()==PlayerPos:======2===="+tmp.ToString());

		MainPlayer.transform.localPosition = tmp;
	}
	private void updateCurrentStatus(){
		if (Mathf.Round(rwd.z) != 0)GameInstanceData.GetInstance.CurrentStatus=0;
		if (Mathf.Round(uwd.z) != 0)GameInstanceData.GetInstance.CurrentStatus=1;
		if (Mathf.Round(fwd.z) != 0)GameInstanceData.GetInstance.CurrentStatus=2;
	}
	private void HandleRotation(int direction){

		Matrix4x4 m = newZeroMatrix ();
		switch (direction) {
		case 0:				//	Up
			m=XAxisRotateMatrix()*xyzwVector();
			break;
		case 1:				//  Down
			m=XAxisRotateMatrix().inverse*xyzwVector();
			break;  		
		case 2:				//	Left
			m=YAxisRotateMatrix()*xyzwVector();
			break;
		case 3:				//	Right
			m=YAxisRotateMatrix().inverse*xyzwVector();
			break;
		case 4:				//	逆时针
			m=ZAxisRotateMatrix()*xyzwVector();
			break;
		case 5:				//	顺时针
			m=ZAxisRotateMatrix().inverse*xyzwVector();
			break;
		}
		Vector3 newFwd = new Vector3 (m [0, 2], m [1, 2], m [2, 2]);
		Vector3 newUwd = new Vector3 (m [0, 1], m [1, 1], m [2, 1]);

		FormRotation = Quaternion.LookRotation(fwd,uwd);
		ToRotation = Quaternion.LookRotation(newFwd,newUwd);

		audio.PlayOneShot(rotate);

		beginTime=Time.time;
		IsRotating=true;
	}
	/*
	 *当前物体的坐标轴在世界坐标系的朝向 
	 * 
	 */

	private void update3axis(){
		fwd = transform.TransformDirection (Vector3.forward);
		uwd = transform.TransformDirection (Vector3.up);
		rwd = Vector3.Cross (uwd, fwd).normalized;
	}
	private void reverse3axis(){
		Matrix4x4 m = xyzwVector ().inverse;
		MoveRwd.x = m [0, 0];MoveRwd.y = m [1, 0];MoveRwd.z = m [2, 0];
		MoveUwd.x = m [0, 1];MoveUwd.y = m [1, 1];MoveUwd.z = m [2, 1];
		MoveFwd.x = m [0, 2];MoveFwd.y = m [1, 2];MoveFwd.z = m [2, 2];
	}
	/*
	 *物体朝向的坐标矩阵 
	 * 
	 */
	private Matrix4x4 xyzwVector(){
		Matrix4x4 m = newZeroMatrix ();
		update3axis ();

		Vector4 v1 = new Vector4 (fwd.x, fwd.y, fwd.z, 0);
		Vector4 v2 = new Vector4 (uwd.x, uwd.y, uwd.z, 0);
		Vector4 v3 = new Vector4 (rwd.x, rwd.y, rwd.z, 0);

		m.SetColumn (0, v3);
		m.SetColumn (1, v2);
		m.SetColumn (2, v1);
		m.SetColumn (3, new Vector4 (0, 0, 0, 1.0f));
		return m;
	}

	/*
	 * 绕世界坐标轴X,Y,Z轴正向旋转时的旋转变换矩阵，
	 * 正向规定为向该轴正方向看过去，逆时针方向
	 * 
	 * 反向旋转用XAxisRotateMatrix().inverse
	 * 
	 */
	private Matrix4x4 XAxisRotateMatrix(){
		Matrix4x4 m = newZeroMatrix ();
		m [0,0] = 1;		//	1 0  0 0      向X轴正向看去，逆时针旋转90°
		m [1,2] = -1;		//  0 0 -1 0	  绕世界坐标轴
		m [2,1] = 1;		//  0 1  0 0
		m [3,3] = 1;		//  0 0  0 1
		return m;
	}
	private Matrix4x4 YAxisRotateMatrix(){
		Matrix4x4 m = newZeroMatrix ();
		m [0,2] = 1;		//	 0 0 1 0      向Y轴正向看去，逆时针旋转90°
		m [1,1] = 1;		//   0 1 0 0      绕世界坐标轴
		m [2,0] = -1;		//  -1 0 0 0
		m [3,3] = 1;		//   0 0 0 1
		return m;
	}
	private Matrix4x4 ZAxisRotateMatrix(){
		Matrix4x4 m = newZeroMatrix ();
		m [0,1] = -1;		//	0 -1 0 0      向Z轴正向看去，逆时针旋转90°
		m [1,0] = 1;		//  1  0 0 0      绕世界坐标轴
		m [2,2] = 1;		//  0  0 1 0
		m [3,3] = 1;		//  0  0 0 1
		return m;
	}
	
	/*
	 * 构造一个4X4零矩阵
	 * 
	 */
	private Matrix4x4 newZeroMatrix(){
		Matrix4x4 m = new Matrix4x4 ();
		for (int i=0; i<16; i++) {
			m [i] = 0;
		}
		return m;
	}
}
