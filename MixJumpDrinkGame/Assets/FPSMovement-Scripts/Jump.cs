using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Jump : MonoBehaviour
{
    Rigidbody rb;
    [SerializeField] float jumpForce;
    [SerializeField] Transform groundChecker;
    [SerializeField] float checkRadius;
    [SerializeField] LayerMask groundLayer;
    [SerializeField] public float impulseforward;
    [SerializeField] float acceleration;
    private Movement movement;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
        movement = GetComponent<Movement>();
    }

    void FixedUpdate()
    {

        if (Input.GetKey(KeyCode.Space) && IsOnGround())
        {
            DoJump();
        }
        if (!IsOnGround())
        {
            rb.AddForce(transform.forward * acceleration, ForceMode.Force);
            
        }

        print(IsOnGround());
    }

    public bool IsOnGround()
    {
        Collider[] colliders = Physics.OverlapSphere(groundChecker.position, checkRadius, groundLayer);
        
        if (colliders.Length > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public void DoJump()
    {
        rb.AddForce(Vector3.up * jumpForce, ForceMode.Impulse);
        rb.AddForce(transform.forward * impulseforward, ForceMode.Impulse);
    }

   

}
