using UnityEngine;
using System.Collections;
using System;
using System.IO;
using UnityEngine.UI;
public class FileUtilities : MonoBehaviour {

	public GameObject Bricks,Player,BricksParentObj,Exit;

	private GameObject PlayerMain,_Exit;
	private static string FILENAME;
	string Error="";
	void Start () {
//		Screen.autorotateToLandscapeLeft = false;
//		Screen.autorotateToLandscapeRight = false;
//		Screen.autorotateToPortrait = false;
//		Screen.autorotateToPortraitUpsideDown = false;
//		Screen.orientation = ScreenOrientation.LandscapeLeft;
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
}
