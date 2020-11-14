using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{
    [SerializeField] float speed;
    [SerializeField] float sidetosidespeed;
    Rigidbody rb;
    Jump jumpref;
    
  

    void Start() {
        jumpref = GetComponent<Jump>();
        rb = GetComponent<Rigidbody>();
    }

    void FixedUpdate() {
       
        float x = Input.GetAxisRaw("Horizontal");
        float z = Input.GetAxisRaw("Vertical");



        if (!jumpref.IsOnGround())
        {
            speed = 2;
            sidetosidespeed = 3;
        }
        else
        {
            sidetosidespeed = 1;
            speed = 5;
        }


        Vector3 moveBy = transform.right * x * sidetosidespeed + transform.forward * z ;


        rb.MovePosition(transform.position + moveBy.normalized * speed * Time.deltaTime);
    }

}
