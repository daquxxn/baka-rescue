using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy1 : BaseEnemy
{
    [SerializeField] private int _rotationSpeed = 10;
    [SerializeField] private Transform _trans = null;
    [SerializeField] private int _dir = -1; 
    [SerializeField] private float _clampRotation = 0f; 

    

    private void Update()
    {
        if(_dir == 1 && _trans.rotation.x >= _clampRotation/1000)
         {
             _dir = -1;
         }
         else if(_trans.rotation.x <= -_clampRotation/1000)
         {
             _dir = 1;
         }
        _trans.transform.Rotate(Vector3.right * (_rotationSpeed * _dir * Time.deltaTime));
    }
}