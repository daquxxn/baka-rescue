using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlateformTrigger : MonoBehaviour
{
    [SerializeField] private MovablePlateform _plateform;

    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.layer == 9)
        _plateform.NextPlateform();
    }
}
