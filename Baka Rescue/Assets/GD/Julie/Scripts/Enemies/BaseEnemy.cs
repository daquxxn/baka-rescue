using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseEnemy : MonoBehaviour
{
    [SerializeField] protected int _damages = 1; 

    public int Damages
    {
        get
        {
            return _damages;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.layer == 13 && tag != other.tag)
        {
            Destroy(other.gameObject);
        }
    }
}
