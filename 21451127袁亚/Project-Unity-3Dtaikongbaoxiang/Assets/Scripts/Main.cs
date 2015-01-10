using UnityEngine;
using System.Collections;
using UnityEngine.UI;
public class Main : MonoBehaviour {

	private bool flag=false;

	void Start(){
		Screen.autorotateToLandscapeLeft = false;
		Screen.autorotateToLandscapeRight = false;
		Screen.autorotateToPortrait = false;
		Screen.autorotateToPortraitUpsideDown = false;
		Screen.orientation = ScreenOrientation.LandscapeLeft;

		int textSize = 16 + Screen.width / 60;
		GameObject obj;
		obj = GameObject.Find ("Text_Tips");
		if(obj!=null)obj.GetComponent<Text> ().fontSize = textSize*2;
		obj = GameObject.Find ("TextbtnStart");
		if(obj!=null)obj.GetComponent<Text> ().fontSize = textSize;
		obj = GameObject.Find ("TextbtnExit");
		if(obj!=null)obj.GetComponent<Text> ().fontSize = textSize;
		obj = GameObject.Find ("Text_Level");
		if(obj!=null)obj.GetComponent<Text> ().fontSize = textSize;
		obj = GameObject.Find ("Text_Steps");
		if(obj!=null)obj.GetComponent<Text> ().fontSize = textSize;
		obj = GameObject.Find ("Text_ErrorDisc");
		if(obj!=null)obj.GetComponent<Text> ().fontSize = textSize;
		obj = GameObject.Find ("TextExit");
		if(obj!=null)obj.GetComponent<Text> ().fontSize = textSize;
		obj = GameObject.Find ("TextInfo");
		if(obj!=null)obj.GetComponent<Text> ().fontSize = textSize;

	}

	void StartNewGame(){
		Application.LoadLevel ("main");
	}
	void ExitGame(){
		Application.Quit ();
	}
	void AboutToExit(){
		bool flag = GameObject.Find ("CanvasExitConfirm").GetComponent<Canvas> ().enabled;
		GameObject.Find ("CanvasExitConfirm").GetComponent<Canvas> ().enabled = !flag;
	}
	void CancelExit(){
		bool flag = GameObject.Find ("CanvasExitConfirm").GetComponent<Canvas> ().enabled;
		GameObject.Find ("CanvasExitConfirm").GetComponent<Canvas> ().enabled = !flag;
	}
	void DoExitToMain(){
		Application.LoadLevel ("StartUI");
	}
	void ShowInfo(){
		if (flag) {
			FreeRotate.TipInfo = "";
		} else {
			FreeRotate.TipInfo = "3D太空宝箱\nA,S,D,W控制旋转，上下左右方向键控制移动\n屏幕左半边控制旋转，右半边控制移动，用手势操作";		
		}
		flag = !flag;
	}
}
