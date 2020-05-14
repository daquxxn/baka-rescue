using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy1 : MonoBehaviour
{
    [SerializeField] private int _rotationSpeed = 10;
    [SerializeField] private Transform _trans = null;

    

    private void Start()
    {
    }


    private void Update()
    {
        if (_trans.rotation.x <= 180)
    _trans.transform.Rotate(Vector3.right * (_rotationSpeed * Time.deltaTime));
    }
}