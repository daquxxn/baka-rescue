using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowPoint : MonoBehaviour
{
    [SerializeField] private Transform _toFollow;

    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update ()
    {
        transform.position = _toFollow.transform.position;
    }
}
