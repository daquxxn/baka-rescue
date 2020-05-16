using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlateformTrigger : MonoBehaviour
{
    [SerializeField] private MovablePlateform _plateform;

    private void OnTriggerEnter(Collider other)
    {
        _plateform.NextPlateform();
    }
}
