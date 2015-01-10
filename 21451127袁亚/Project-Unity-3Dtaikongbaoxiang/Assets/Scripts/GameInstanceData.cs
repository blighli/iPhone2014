using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class GameInstanceData{
	private static GameInstanceData instance;

	private int Int_GameLevel=1;
	private int Int_Steps=0;
	private static int size=30;
	private int[,,] _ColliderCoordinates=new int[size,size,size];
	private string FILENAME="Data/map.txt";

	private string _GameScene="main";//"main";
	private string _StartScene="StartUI";
	private string _PlayerMain="PlayerMain";

	private Transform _CurrentSelectedBrick;
	public Transform CurrentSelectedBrick{
		get{return this._CurrentSelectedBrick;}
		set{this._CurrentSelectedBrick=value;}
	}
	public string FileName{
		get{return this.FILENAME;}
	}
	public string GameScene{
		get{return this._GameScene;}
	}
	public string StartScene{
		get{return this._StartScene;}
	}
	public string PlayerMain{
		get{return this._PlayerMain;}
	}
	//private string FOLDER = "Data";

	public void ResetColliderCoordinates(){
		for (int i=0; i<size; i++)
			for (int j=0; j<size; j++)
				for (int k=0; k<size; k++)
					_ColliderCoordinates [i, j, k] = 0;
		Int_Steps = 0;
	}

	private Vector3 _PlayerPos;
	private int _CurrentStatus=2;
	private int _XSize, _YSize, _ZSize;

	public string _Text_Level="Text_Level";
	public string _Text_Steps = "Text_Steps";
	public string _Text_Tips="Text_Tips";

	public static GameInstanceData GetInstance{
		get{
			if(instance==null)instance=new GameInstanceData();
			return instance;
		}
	}

	public void SetText(string TextObjName, string str){
		GameObject obj = GameObject.Find (TextObjName);
		if (obj == null) {
			Debug.Log("Can not find gameObject \""+TextObjName+"\"");
			return;
		}
		obj.GetComponent<Text> ().text = str;

	}
	public int GameLevel{
		get{return Int_GameLevel;}
		set{Int_GameLevel=value;}
	}
	public Vector3 PlayerPos{
		get{return _PlayerPos;}
		set{_PlayerPos=value;}
	}
	public int CurrentStatus{
		get{return _CurrentStatus;}
		set{_CurrentStatus=value;}
	}
	public Vector3 GetOrthographicPos(int index){
		switch (index) {
		case 0:
			return new Vector3(_XSize/2+1,_PlayerPos.y,_PlayerPos.z);
		case 1:
			return new Vector3(_PlayerPos.x,_YSize/2+1,_PlayerPos.z);
		case 2:
			return new Vector3(_PlayerPos.x,_PlayerPos.y,_ZSize/2+1);
		default:
			return Vector3.zero;
		}
	}
	public int GetColliderStatus(int i,int j,int k){
		return _ColliderCoordinates[i+size/2,j+size/2,k+size/2];
	}
	public void SetColliderStatus(int i,int j,int k,int value){
		this._ColliderCoordinates [i+size/2,j+size/2, k+size/2] = value;
	}
	public int XSize{
		get{return this._XSize;}
		set{this._XSize=value;}
	}
	public int YSize{
		get{return this._YSize;}
		set{this._YSize=value;}
	}
	public int ZSize{
		get{return this._ZSize;}
		set{this._ZSize=value;}
	}
	public int Steps{
		get{return this.Int_Steps;}
		set{this.Int_Steps=value;}
	}
}
