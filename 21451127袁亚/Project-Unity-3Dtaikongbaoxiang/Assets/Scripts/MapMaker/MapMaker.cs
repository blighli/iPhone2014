using UnityEngine;
using System.Collections;
using System;
using System.IO;
using UnityEngine.UI;
public class MapMaker : MonoBehaviour {
	public GameObject BrickPrefab;

	private static string DATA_HEAD="STARTTAG<001>\n11x11x11\n";
	private static string DATA_MAIN="";
	private float TimeGap=1f;
	private float BeginTime=0;
	private GameObject PlayerMain,Exit,Bricks;
	private Vector3 OriginPos;
	void Start () {
		PlayerMain = FindObj ("PlayerMain");
		OriginPos=PlayerMain.transform.localPosition;
		Exit = FindObj ("Exit");
		initGame ();
		BeginTime = Time.time;
	}
	void ReloadGame(){
		GameObject.Find ("Map").transform.rotation = Quaternion.identity;
		PlayerMain.transform.localPosition=OriginPos;
		//initBricks ();
	}
	void Update(){
		if (Time.time - BeginTime > TimeGap) {
			BeginTime=Time.time;
			initBricks ();
			updateMainDATA ();
		}
	}
	GameObject FindObj(string name){
		return GameObject.Find (name) as GameObject;
	}
	void InitGameInstanceData (){
		GameInstanceData.GetInstance.ResetColliderCoordinates ();
		GameInstanceData.GetInstance.PlayerPos = Vector3.zero;
		GameInstanceData.GetInstance.SetText (GameInstanceData.GetInstance._Text_Tips, "");
	}
	void initGame(){
		InitGameInstanceData ();
		initMapSize ();
		initBricks ();
		initPlayerAndExit ();
		updateMainDATA ();
	}
	void initMapSize(){
		GameInstanceData.GetInstance.XSize = 11;
		GameInstanceData.GetInstance.YSize = 11;
		GameInstanceData.GetInstance.ZSize = 11;
	}
	void initBricks(){
		GameObject parentobj = FindObj ("Brick");

		Transform parentTransform = parentobj.transform.parent.transform;
		int i,j,k;
		foreach (Transform child in parentTransform) {
			//Debug.Log(child.gameObject.name);
			i=Mathf.RoundToInt(child.localPosition.x);
			j=Mathf.RoundToInt(child.localPosition.y);
			k=Mathf.RoundToInt(child.localPosition.z);
			child.localPosition=new Vector3(i,j,k);
			GameInstanceData.GetInstance.SetColliderStatus(i,j,k,13);
			GameInstanceData.GetInstance.SetColliderStatus(6,j,k,1);
			GameInstanceData.GetInstance.SetColliderStatus(i,6,k,1);
			GameInstanceData.GetInstance.SetColliderStatus(i,j,6,1);
		}

	}
	void initPlayerAndExit(){
		int i,j,k;
		i = Mathf.RoundToInt(PlayerMain.transform.localPosition.x);
		j = Mathf.RoundToInt(PlayerMain.transform.localPosition.y);
		k = Mathf.RoundToInt(PlayerMain.transform.localPosition.z);
		PlayerMain.transform.localPosition = new Vector3 (i, j, k);
		GameInstanceData.GetInstance.PlayerPos = new Vector3 (i, j, k);
		//GameInstanceData.GetInstance.SetColliderStatus (i, j, k, 11);
		i = Mathf.RoundToInt(Exit.transform.localPosition.x);
		j = Mathf.RoundToInt(Exit.transform.localPosition.y);
		k = Mathf.RoundToInt(Exit.transform.localPosition.z);
		Exit.transform.localPosition = new Vector3 (i, j, k);
		GameInstanceData.GetInstance.SetColliderStatus(6,j,k,2);
		GameInstanceData.GetInstance.SetColliderStatus(i,6,k,2);
		GameInstanceData.GetInstance.SetColliderStatus(i,j,6,2);
		GameInstanceData.GetInstance.SetColliderStatus (i, j, k, 12);
	}
	void updateMainDATA(){
		int i, j, k,tmp=0;
		i = Mathf.RoundToInt(OriginPos.x);
		j = Mathf.RoundToInt(OriginPos.y);
		k = Mathf.RoundToInt(OriginPos.z);
		GameInstanceData.GetInstance.SetColliderStatus(i,j,k,11);

		DATA_MAIN = "";
		for (i=0; i<11; i++){
			DATA_MAIN+=i.ToString()+"\n";
			for (j=0; j<11; j++){
				for (k=0; k<11; k++) {
					tmp=GameInstanceData.GetInstance.GetColliderStatus(k-5,i-5,j-5);
					if(tmp==0){
						DATA_MAIN+=".";
					}else if(tmp==11){
						DATA_MAIN+="P";
					}else if(tmp==12){
						DATA_MAIN+="E";
					}else if(tmp==13){
						DATA_MAIN+="1";
					}
				}
				DATA_MAIN+="\n";
			}
		}
	}
	void AddBrick(){
		GameObject obj = Instantiate (BrickPrefab, Vector3.zero, Quaternion.identity) as GameObject;
		//GameObject objparent = GameObject.Find ("Bricks");
		obj.name = "Brick";
		obj.transform.parent = GameObject.Find ("Brick").transform.parent;
		GameObject.Find ("Map").SendMessage ("initBricks");

	}
	void RemoveBrick(){
		Transform trans = GameInstanceData.GetInstance.CurrentSelectedBrick;
		Destroy (trans.gameObject);
		GameInstanceData.GetInstance.CurrentSelectedBrick = null;
		GameObject.Find ("Map").SendMessage ("delBricks");
	}
	void WriteToFile(){
		updateMainDATA ();
		
		WriteToFile ("Data/mapmaker.txt",DATA_HEAD+DATA_MAIN);
	}
	void WriteToFile(string name,string data){
		StreamWriter sw; 
		string tmp = GetPath ();
		FileInfo t = new FileInfo(tmp+"/"+ name);          
		if(!t.Exists)          
		{            
			sw = t.CreateText();
		}          
		else      
		{
			sw = t.AppendText();         
		} 
		sw.WriteLine(data);
		sw.Close();
		sw.Dispose();
	}
	private string GetPath(){
		string path="";
		if(Application.platform==RuntimePlatform.Android)
		{
			path=Application.persistentDataPath;
		}
		else if(Application.platform==RuntimePlatform.WindowsPlayer)
		{
			path=Application.dataPath;
		}
		else if(Application.platform==RuntimePlatform.WindowsEditor)
		{
			path=Application.dataPath;
		}
		return path;
	}
//	private void createORwriteConfigFile(string path,string name,string info)
//	{
//		StreamWriter sw;          
//		FileInfo t = new FileInfo(path+"//"+ name);          
//		if(!t.Exists)          
//		{            
//			sw = t.CreateText();
//		}          
//		else      
//		{
//			sw = t.AppendText();         
//		} 
//		sw.WriteLine(info);
//		sw.Close();
//		sw.Dispose();
//	}
	/*

	public GameObject Bricks,Player,BricksParentObj,Exit;
	
	private GameObject PlayerMain,_Exit;
	private static string FILENAME;
	string Error="";
	void Start () {
		Screen.autorotateToLandscapeLeft = false;
		Screen.autorotateToLandscapeRight = false;
		Screen.autorotateToPortrait = false;
		Screen.autorotateToPortraitUpsideDown = false;
		Screen.orientation = ScreenOrientation.LandscapeLeft;
		InitGameInstanceData ();
		FILENAME = GameInstanceData.GetInstance.FileName;
		initGame ();
	}
	void InitGameInstanceData (){
		GameInstanceData.GetInstance.ResetColliderCoordinates ();
		GameInstanceData.GetInstance.PlayerPos = Vector3.zero;
		GameInstanceData.GetInstance.SetText (GameInstanceData.GetInstance._Text_Tips, "");
	}
	void initGame(){
		string path="";
		if(Application.platform==RuntimePlatform.Android)
		{
			path=Application.persistentDataPath;
		}
		else if(Application.platform==RuntimePlatform.WindowsPlayer)
		{
			path=Application.dataPath;
		}
		else if(Application.platform==RuntimePlatform.WindowsEditor)
		{
			path=Application.dataPath;
		}
		Error=LoadMap(path,FILENAME);
		
		if (Error!= "") {
			//GameInstanceData.GetInstance.SetText(GameInstanceData.GetInstance._Text_Tips,"Loading data error!");
		}
		else
		{
			Debug.Log("Load data succeed!");
		}
	}
	void OnGUI(){
		if (Error != "")
			GameObject.Find ("Text_ErrorDisc").GetComponent<Text> ().text = "ERROR:" + Error;
		//GameInstanceData.GetInstance.SetText(GameInstanceData.GetInstance._Text_Tips,"Loading data error!"+Error);
		
	}

	*/
	/*

	private string LoadMap(string path,string name)    
	{     
		string filename = path +"/"+ name;
		FileInfo t = new FileInfo(filename);          
		if(!t.Exists)
		{
			return "Not Exist,path="+filename;
		}
		StreamReader sr =null;    
		sr = File.OpenText(filename);
		string line;   
		string data;
		
		bool LevelExist = false;
		while(true){
			line = sr.ReadLine ();
			if(line==null)break;
			if(line.Length<8)continue;
			if(line.Substring(0,8)=="STARTTAG" ){
				if(int.Parse(line.Substring(9,3))==GameInstanceData.GetInstance.GameLevel){
					//GameLevel++;
					LevelExist=true;
					break;
				}
			}
		}
		
		if (!LevelExist) {
			return "Level "+GameInstanceData.GetInstance.GameLevel+" not exist";		
		}
		
		line = sr.ReadLine ();				//读取地图大小数据
		int XAxis=0, YAxis=0,ZAxis=0;
		XAxis = int.Parse (line.Substring (0, 2));
		YAxis = int.Parse (line.Substring (3, 2));
		ZAxis = int.Parse (line.Substring (6, 2));
		int xoffset = XAxis / 2;
		int yoffset = YAxis / 2;
		int zoffset = ZAxis / 2;
		
		GameInstanceData.GetInstance.XSize = XAxis;
		GameInstanceData.GetInstance.YSize = YAxis;
		GameInstanceData.GetInstance.ZSize = ZAxis;
		
		int TotalBricks = 0;
		for(int i=0;i<YAxis;i++)
		{
			line = sr.ReadLine();
			if(line==null)return "Error!";
			
			for(int j=0;j<ZAxis;j++){
				line = sr.ReadLine();
				if(line==null)return "Error!";
				
				for(int k=0;k<XAxis;k++){
					data=line.Substring(k,1);
					Vector3 pos=new Vector3(k-XAxis/2,i-YAxis/2,j-ZAxis/2);
					switch(data){
					case "E":
						_Exit=Instantiate(Exit,pos,Quaternion.identity) as GameObject;
						_Exit.name="Exit";
						_Exit.transform.parent=GameObject.Find("Map").transform;
						GameInstanceData.GetInstance.SetColliderStatus(XAxis-xoffset,i-yoffset,j-zoffset,2);
						GameInstanceData.GetInstance.SetColliderStatus(k-xoffset,YAxis-yoffset,j-zoffset,2);
						GameInstanceData.GetInstance.SetColliderStatus(k-xoffset,i-yoffset,ZAxis-zoffset,2);
						break;
					case "P":
						PlayerMain= Instantiate (Player, pos, Quaternion.identity) as GameObject;
						PlayerMain.name="PlayerMain";
						PlayerMain.transform.parent=GameObject.Find("Map").transform;
						GameInstanceData.GetInstance.PlayerPos=pos;//-new Vector3(XAxis/2,YAxis/2,ZAxis/2);
						break;
					case "1":
						GameObject _Brick= Instantiate (Bricks, pos, Quaternion.identity) as GameObject;
						_Brick.name="Brick_"+pos.x+"_"+pos.y+"_"+pos.z;
						_Brick.transform.parent=BricksParentObj.transform;
						TotalBricks++;
						GameInstanceData.GetInstance.SetColliderStatus(XAxis-xoffset,i-yoffset,j-zoffset,1);
						GameInstanceData.GetInstance.SetColliderStatus(k-xoffset,YAxis-yoffset,j-zoffset,1);
						GameInstanceData.GetInstance.SetColliderStatus(k-xoffset,i-yoffset,ZAxis-zoffset,1);
						break;
					default:
						break;
					}
				}
			}
		}
		BricksParentObj.name += "_" + TotalBricks;
		sr.Close();
		sr.Dispose();
		return "";
	}      

	*/
}

