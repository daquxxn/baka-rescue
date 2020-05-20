using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StaticPlateform : MonoBehaviour
{
    [SerializeField] private int _downValue = 0;
    private Vector3 _initialPosition;

    private void Start()
    {
        _initialPosition = transform.position;
    }

    private void Update()
    {

    }
    private void OnTriggerEnter(Collider other)
    {
        other.transform.parent = transform;
        transform.position = new Vector3(transform.position.x, _downValue, transform.position.z);
    }
    private void OnTriggerExit(Collider other)
    {
        transform.position = _initialPosition;
    }
}
