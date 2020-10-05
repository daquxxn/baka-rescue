using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovablePlateformTrigger : MonoBehaviour
{
    [SerializeField] private Transform _parent = null;

    private void OnTriggerEnter(Collider other)
    {
        ElementalProjectile elemProj = other.GetComponent<ElementalProjectile>();
        if (elemProj == null)
        {
            other.transform.parent = _parent;
        }
    }
   

    private void OnTriggerExit(Collider other)
    {
            other.transform.parent = null;
    }
}
