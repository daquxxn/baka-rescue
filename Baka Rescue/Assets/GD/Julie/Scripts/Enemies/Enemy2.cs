using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy2 : BaseEnemy
{
    [SerializeField] private float _moveSpeed = 0f;
    private Rigidbody _rb = null;
    [SerializeField] private Vector3 _moveDir;
    [SerializeField] private LayerMask _wallEnemies;
    [SerializeField] private float _maxDistanceFromWall = 0f;

    // Start is called before the first frame update
    void Start()
    {
        _rb = GetComponent<Rigidbody>();
        _moveDir = ChooseDirection();
        transform.rotation = Quaternion.LookRotation(_moveDir);
    }

    // Update is called once per frame
    void Update()
    {
        _rb.velocity = _moveDir * _moveSpeed;

        if(Physics.Raycast(transform.position, transform.forward, _maxDistanceFromWall, _wallEnemies))
        {
            _moveDir = ChooseDirection();
            transform.rotation = Quaternion.LookRotation(_moveDir);
        }
    }

    Vector3 ChooseDirection()
    {
        Vector3 temp = new Vector3();
        temp = -transform.forward;

        return temp;
    }
    
}
