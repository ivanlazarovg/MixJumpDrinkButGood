using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{
    [SerializeField] public float speed;
    [SerializeField] float sidetosidespeed;

    Rigidbody rb;
    Jump jumpref;

    public LayerMask groundLayer;
    public Transform groundChecker;
    public float checkRadius;
  
    void Start()
    {

        jumpref = GetComponent<Jump>();
        rb = GetComponent<Rigidbody>();

    }

    void FixedUpdate()
    {
       
        float x = Input.GetAxisRaw("Horizontal");
        float z = Input.GetAxisRaw("Vertical");

        if (!jumpref.IsOnGround())
        {
            speed = 2;
            sidetosidespeed = 3;
        }
        else
        {
            Collider[] colliders = Physics.OverlapSphere(groundChecker.position, checkRadius, groundLayer);

            if(colliders[0].gameObject.tag == "BadGround")
            {
                speed = 3;
                jumpref.impulseforward = 4;
                sidetosidespeed = 1;
            }
            else
            {
                sidetosidespeed = 1;
                speed = 5;
                jumpref.impulseforward = 6;
            }
        }

        Vector3 moveBy = transform.right * x * sidetosidespeed + transform.forward * z ;

        rb.MovePosition(transform.position + moveBy.normalized * speed * Time.deltaTime);
    }


}
