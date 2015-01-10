using UnityEngine;
using System;
using System.Collections;

public class BoundaryManger : MonoBehaviour {
  public  GameObject camera;
   public GameObject gm1;
   public GameObject gm2;
    double width, height;
	// Use this for initialization
	void Start ()
    {
        height = camera.camera.orthographicSize;
        width = ((double)Screen.width /Convert.ToDouble(Screen.height))*height;
	}
	
	// Update is called once per frame
	void Update ()
    {
        if (Math.Abs(gm1.transform.position.x - gm1.renderer.bounds.size.x/2) >= width)
        {
            gm1.transform.position = new Vector2((float)(-width + gm1.renderer.bounds.size.x / 2), gm1.transform.position.y);
            gm1.rigidbody2D.velocity =new Vector2(-0.9f * gm1.rigidbody2D.velocity.x,gm1.rigidbody2D.velocity.y);
        }
        else if(Math.Abs(gm1.transform.position.x + gm1.renderer.bounds.size.x/2) >= width)
        {
            gm1.transform.position = new Vector2((float)(width - gm1.renderer.bounds.size.x / 2), gm1.transform.position.y);
            gm1.rigidbody2D.velocity = new Vector2(-0.9f * gm1.rigidbody2D.velocity.x, gm1.rigidbody2D.velocity.y);
        }
        if (Math.Abs(gm1.transform.position.y - gm1.renderer.bounds.size.y/2) >= height)
        {
            gm1.transform.position = new Vector2(gm1.transform.position.x,(float)(-height + gm1.renderer.bounds.size.y / 2));
            gm1.rigidbody2D.velocity = new Vector2(gm1.rigidbody2D.velocity.x, -0.9f*gm1.rigidbody2D.velocity.y);
        }
        else if( Math.Abs(gm1.transform.position.y + gm1.renderer.bounds.size.y/2) >= height)
        {
            gm1.transform.position = new Vector2(gm1.transform.position.x, (float)(height- gm1.renderer.bounds.size.y / 2));
            gm1.rigidbody2D.velocity = new Vector2(gm1.rigidbody2D.velocity.x, -0.9f * gm1.rigidbody2D.velocity.y);
        }
        if (Math.Abs(gm2.transform.position.x - gm2.renderer.bounds.size.x / 2) >= width)
        {
            gm2.transform.position = new Vector2((float)(-width + gm2.renderer.bounds.size.x / 2), gm2.transform.position.y);
            gm2.rigidbody2D.velocity = new Vector2(-0.9f * gm2.rigidbody2D.velocity.x, gm2.rigidbody2D.velocity.y);
        }
        else if (Math.Abs(gm2.transform.position.x + gm2.renderer.bounds.size.x / 2) >= width)
        {
            gm2.transform.position = new Vector2((float)(width - gm2.renderer.bounds.size.x / 2), gm2.transform.position.y);
            gm2.rigidbody2D.velocity = new Vector2(-0.9f * gm2.rigidbody2D.velocity.x, gm2.rigidbody2D.velocity.y);
        }
        if (Math.Abs(gm2.transform.position.y - gm2.renderer.bounds.size.y / 2) >= height)
        {
            gm2.transform.position = new Vector2(gm2.transform.position.x, (float)(-height + gm2.renderer.bounds.size.y / 2));
            gm2.rigidbody2D.velocity = new Vector2(gm2.rigidbody2D.velocity.x, -0.9f * gm2.rigidbody2D.velocity.y);
        }
        else if (Math.Abs(gm2.transform.position.y + gm2.renderer.bounds.size.y / 2) >= height)
        {
            gm2.transform.position = new Vector2(gm2.transform.position.x, (float)(height - gm2.renderer.bounds.size.y / 2));
            gm2.rigidbody2D.velocity = new Vector2(gm2.rigidbody2D.velocity.x, -0.9f * gm2.rigidbody2D.velocity.y);
        }
	}
}
