using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowPoint : MonoBehaviour
{
    [SerializeField] private Transform _toFollow;

    // Start is called before the first frame update
    void Start()
    {
        GameLoopManager.Instance.GameLoop += Loop;
    }

    // Update is called once per frame
    void Loop()
    {
        transform.position = _toFollow.transform.position;
    }
}
